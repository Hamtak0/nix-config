# A NixOS module to send notifications for low and critical battery levels.
#
# To use, import this file into your `configuration.nix` and enable the service:
#
# { inputs, ... }:
# {
#   imports = [ inputs.self.nixosModules.asus-battery-limit ];
#
#   services.asus-battery-limit.enable = true;
#
#   # Optional: customize thresholds and battery device
#   # services.asus-battery-limit.batteryDevice = "BAT1";
# }
{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  cfg = config.services.asus-battery-limit;

  # This is the shell script that will be executed by the systemd service.
  # It checks the battery status and sends a notification if necessary.
  battery-check-script = pkgs.writeShellScript "apply-battery-limit" ''
    #!${pkgs.bash}/bin/bash
    set -euo pipefail

    # --- Configuration ---
    LIMIT_PATH="/sys/class/power_supply/${cfg.batteryDevice}/charge_control_end_threshold"
    THRESHOLD="${toString cfg.chargeThreshold}"

    # --- Pre-flight Checks ---
    # Ensure that the threshold limit path file exist.
    if [ ! -f "$LIMIT_PATH" ]; then
      echo "Battery device ${cfg.batteryDevice} not found with the charge_control_end_threshold at $LIMIT_PATH. Exiting."
      exit 0
    fi

    # --- Main Logic ---
    # This is the standard Linux kernel interface for Asus-WMI battery management.
    # It interfaces with the laptop firmware to stop charging at the defined percentage.
    echo "$THRESHOLD" > "$LIMIT_PATH"
    echo "Successfully set Asus battery charge limit to $THRESHOLD% on ${cfg.batteryDevice}."
  '';
in
{
  # --- Module Options ---
  # This section defines the configuration options that users can set.
  options.services.asus-battery-limit = {
    enable = mkEnableOption "Asus battery charge limit service";

    chargeThreshold = mkOption {
      type = types.int;
      default = 80;
      description = "The battery percentage at which the battery should stop charging.";
    };

    batteryDevice = mkOption {
      type = types.str;
      default = "BAT0";
      description = "The name of the battery device in /sys/class/power_supply/.";
    };
  };

  # --- Module Implementation ---
  # This section defines the systemd services based on the configuration.
  config = mkIf cfg.enable {
    # The Service (Runs the script)
    # Note: This is a system service because writing to /sys requires root privileges.
    systemd.services.asus-battery-limit = {
      description = "Set Asus battery charge limit to ${toString cfg.chargeThreshold}%";
      # Reference: multi-user.target ensures the system has reached a state
      # where hardware drivers (like asus-wmi) are fully loaded and sysfs paths are available.
      after = [ "multi-user.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${battery-check-script}";
        RemainAfterExit = true;
      };
    };

    # The timer (Runs the service periodically)
    systemd.timers.asus-battery-limit = {
      description = "Timer to periodically re-apply Asus battery limit";
      wantedBy = [ "timers.target" ];

      timerConfig = {
        # Run 1 minute after boot, and every 2 hours thereafter
        OnBootSec = "1m";
        OnUnitActiveSec = "2h";
        Unit = "asus-battery-limit.service";
      };
    };
  };
}

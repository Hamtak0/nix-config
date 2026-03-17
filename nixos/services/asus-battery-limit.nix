{ pkgs, ... }:
{
  systemd.services.asus-battery-limit = {
    description = "Set Asus battery charge limit";

    # Reference: multi-user.target ensures the system has reached a state
    # where hardware drivers (like asus-wmi) are fully loaded and sysfs paths are available.
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";

      # This is the standard Linux kernel interface for Asus-WMI battery management.
      # It interfaces with the laptop firmware to stop charging at the defined percentage.
      # '|| true' is used to prevent the service from failing if the file is momentarily locked.
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 80 > /sys/class/power_supply/BAT1/charge_control_end_threshold || true'";

      RemainAfterExit = true;
    };
  };
}

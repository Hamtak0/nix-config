{
  inputs,
  pkgs,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;
    # plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [ hyprscrolling ];
    settings = {
      input = {
        kb_layout = "us";
	numlock_by_default = true;
	repeat_rate = 40;
        repeat_delay = 200;
        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "flat";
      };

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 1;
        layout = "scrolling";
        allow_tearing = true;
      };

      decoration = {
        rounding = 0;
        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          special = false;
        };

        shadow.enabled = false;

        dim_special = 0.5;
      };

      animations = {
        enabled = true;
        animation = [
          "windowsIn, 1, 3, default, popin 50%"
          "windowsOut, 1, 4, default, popin 75%"
          "windowsMove, 1, 3, default"
          "border, 1, 10, default"
          "borderangle, 1, 7.5, default"
          "fade, 1, 7, default"
          "workspaces, 1, 3, default, slidefadevert 10%"
          "specialWorkspace, 1, 4, default, slidefadevert 5%"
          "layers, 1, 2.5, default, fade"
          "fadeLayers, 1, 2.5, default"
        ];
      };

      "$mod" = "SUPER";

      "$term" = "foot";
      "$term_alt" = "foot";

      bind = [
	"$mod, w, killactive"
	"$mod, r, exec, uwsm-app -- rofi -show drun -show-icons"

	"$mod, Return, exec, uwsm-app -- $term"
      ];
    };
  };
}

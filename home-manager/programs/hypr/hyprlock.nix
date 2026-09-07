{ config, ... }:
{
  programs.hyprlock = {
    enable = true;

    settings =
      let
        font = "JetBrainsMono Nerd Font";
      in
      {
        general = {
          hide_cursor = false;
          immediate_render = true;
        };

        animations = {
          enabled = true;
          bezier = [
            "linear, 1, 1, 0, 0"
          ];
          animation = [
            "fadeIn, 1, 5, linear"
            "fadeOut, 1, 5, linear"
            "inputFieldDots, 1, 2, linear"
          ];
        };

        shape = [
          # Main card
          {
            monitor = "";
            size = "480, 420";
            color = "rgba(26, 21, 27, 0.82)";
            rounding = 24;
            border_size = 1;
            border_color = "rgba(254, 223, 225, 0.22)";
            position = "0, 0";
            halign = "center";
            valign = "center";
          }
          # Username pill
          {
            monitor = "";
            size = "320, 48";
            color = "rgba(45, 31, 39, 0.65)";
            rounding = -1;
            border_size = 1;
            border_color = "rgba(254, 223, 225, 0.18)";
            position = "0, -60";
            halign = "center";
            valign = "center";
          }
        ];

        label = [
          # Time
          {
            monitor = "";
            text = "$TIME";
            color = "rgb(253, 239, 242)";
            font_size = 68;
            font_family = "${font} Bold";
            position = "0, 115";
            halign = "center";
            valign = "center";
          }
          # Date
          {
            monitor = "";
            text = "cmd[update:1000] echo \"$(date +\"%A, %B %d\")\"";
            color = "rgb(245, 163, 183)";
            font_size = 18;
            font_family = font;
            position = "0, 50";
            halign = "center";
            valign = "center";
          }
          # Username badge
          {
            monitor = "";
            text = "  $USER";
            color = "rgb(253, 239, 242)";
            font_size = 14;
            font_family = "${font} Bold";
            position = "0, -60";
            halign = "center";
            valign = "center";
          }
        ];

        input-field = [
          {
            monitor = "";
            size = "320, 50";
            outline_thickness = 2;

            dots_center = true;
            dots_size = 0.22;
            dots_spacing = 0.20;
            dots_rounding = -1;

            rounding = -1;
            outer_color = "rgba(254, 223, 225, 0.22)";
            inner_color = "rgba(45, 31, 39, 0.70)";
            font_color = "rgb(253, 239, 242)";
            check_color = "rgb(245, 163, 183)";
            fail_color = "rgb(208, 90, 126)";

            fade_on_empty = false;
            placeholder_text = "<i><span foreground=\"##7d5b6b\">󰌾 Enter Password...</span></i>";
            hide_input = false;
            fail_transition = 200;

            position = "0, -130";
            halign = "center";
            valign = "center";
          }
        ];
      };
    extraConfig = ''
      source = ${config.home.homeDirectory}/.config/hypr/hyprlock.local.conf

      background {
          monitor =
          path = $wallpaper
          blur_passes = 3
          blur_size = 7
          contrast = 0.8916
          brightness = 0.816
          vibrancy = 0.8916
          vibrancy_darkness = 0.0
      }
    '';
  };
}

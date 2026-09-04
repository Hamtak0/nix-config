{
  services.hypridle = {
    enable = true;
    settings =
      let
        dpms_on = "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })'";
        dpms_off = "hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })'";
        re_bright = "brightnessctl -r && brightnessctl -rd asus::kbd_backlight";
        play_sound = "playerctl status 2>/dev/null | grep -q 'Playing'";
      in
      {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
          before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
          after_sleep_cmd = dpms_on; # to avoid having to press a key twice to turn on the display.
          # The general:inhibit_sleep option is used to make sure hypridle can perform certain tasks before the system goes to sleep.
          # 0 -> disables sleep inhibition.
          # 1 -> makes the system wait until hypridle launched general:before_sleep_cmd.
          # 2 -> (auto) selects either 3 or 1 depending on whether hypridle detects if you want to launch hyprlock before sleep.
          # 3 -> makes your system wait until the session gets locked by a lock screen app. This works with all wayland session-lock apps.
          inhibit_sleep = 2;
        };

        listener = [
          {
            # turn off keyboard backlight, delete out the section if you dont have a keyboard backlight.
            timeout = 180; # 3minutes.
            on-timeout = "brightnessctl -s set 15 && brightnessctl -sd asus::kbd_backlight set 0"; # set monitor backlight to minimum, avoid 0 on OLED monitor and turn off keyboard backlight.
            on-resume = re_bright; # monitor backlight restore and turn on keyboard backlight.
          }
          {
            timeout = 300; # 5minutes.
            on-timeout = "loginctl lock-session"; # lock screen
            on-resume = re_bright; # monitor backlight restore and turn on keyboard backlight.
          }
          {
            timeout = 330; # 5.5minutes.
            on-timeout = dpms_off; # screen off when timeout has passed.
            on-resume = "${dpms_on} && ${re_bright}"; # screen on when activity is detected after timeout has fired.
          }
          # The "systemctl suspend" is buggy (black screen while the keyboard and fan is working), if the supergfx didn't set to Hybrid.
          {
            timeout = 3600; # 1hour.
            on-timeout = "${play_sound} || (${dpms_on} && sleep 3 && systemctl suspend)"; # suspend pc if no music is playing in the background.
          }
          {
            timeout = 7200; # 2hours.
            on-timeout = "${play_sound} || systemctl poweroff"; # poweroff pc if no music is playing in the background.
          }
        ];
      };
  };
}

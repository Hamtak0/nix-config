{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
        after_sleep_cmd = "sleep 3 && hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
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
          on-resume = "brightnessctl -r && brightnessctl -rd asus::kbd_backlight"; # monitor backlight restore and turn on keyboard backlight.
        }
        {
          timeout = 300; # 5minutes.
          on-timeout = "loginctl lock-session"; # lock screen
        }
        {
          timeout = 330; # 5.5minutes.
          on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed.
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r"; # screen on when activity is detected after timeout has fired.
        }
        # The "systemctl suspend" is buggy (black screen while the keyboard and fan is working), if the supergfx didn't set to Hybrid.
        {
          timeout = 3600; # 1hour.
          on-timeout = "playerctl status 2>/dev/null | grep -q 'Playing' || (hyprctl dispatch dpms on && sleep 3 && systemctl suspend)"; # suspend pc if no music is playing in the background.
        }
        {
          timeout = 7200; # 2hours.
          on-timeout = "playerctl status 2>/dev/null | grep -q 'Playing' || systemctl poweroff"; # poweroff pc if no music is playing in the background.
        }
      ];
    };
  };
}

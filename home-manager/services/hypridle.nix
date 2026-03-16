{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
        after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
        # The general:inhibit_sleep option is used to make sure hypridle can perform certain tasks before the system goes to sleep.
        # 0 -> disables sleep inhibition.
        # 1 -> makes the system wait until hypridle launched general:before_sleep_cmd.
        # 2 -> (auto) selects either 3 or 1 depending on whether hypridle detects if you want to launch hyprlock before sleep.
        # 3 -> makes your system wait until the session gets locked by a lock screen app. This works with all wayland session-lock apps.
        inhibit_sleep = 2;
      };

      listener = [
        {
          timeout = 90; # 1.5min.
          on-timeout = "brightnessctl -s set 15"; # set monitor backlight to minimum, avoid 0 on OLED monitor.
          on-resume = "brightnessctl -r"; # monitor backlight restore.
        }
        {
          # turn off keyboard backlight, comment out this section if you dont have a keyboard backlight.
          timeout = 90; # 1.5min.
          on-timeout = "brightnessctl -sd asus::kbd_backlight set 0"; # turn off keyboard backlight.
          on-resume = "brightnessctl -rd asus::kbd_backlight"; # turn on keyboard backlight.
        }
        {
          timeout = 300; # 5min
          on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
        }
        {
          timeout = 330; # 5.5min
          on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r"; # screen on when activity is detected after timeout has fired.
        }
        {
          timeout = 3600; # 2hours
          on-timeout = "systemctl suspend"; # suspend pc
        }
      ];
    };
  };
}

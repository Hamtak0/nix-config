{...}: {
  programs.rofi = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings.bind = [
    "$mod, r, exec, uwsm-app -- rofi -show drun -show-icons"
  ];
}

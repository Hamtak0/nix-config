{...}: {
  programs.rofi = {
    enable = true;
    terminal = "foot";

  };

  wayland.windowManager.hyprland.settings.bind = [
    "$mod, r, exec, uwsm-app -- rofi -show drun -show-icons"
    "$mod, a, exec, uwsm-app -- rofi -show run -show-icons"
  ];
}

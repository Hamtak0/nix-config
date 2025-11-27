{...}: {
  programs.rofi = {
    enable = true;
    terminal = "foot";

  };

  # Using programs/hyprland/default.nix instead
  #wayland.windowManager.hyprland.settings.bind = [
  #  "$mod, r, exec, uwsm-app -- rofi -show drun -show-icons"
  #  "$mod, a, exec, uwsm-app -- rofi -show run -show-icons"
  #];
}

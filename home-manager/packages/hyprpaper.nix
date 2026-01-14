{ pkgs, ... }:
{
  home.packages = [
    pkgs.hyprpaper
  ];

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      # splash_offset = 2.0;
      ipc = "on";
      preload = [
        "/home/tako/Pictures/Wallpaper/windows-11.jpg"
      ];
      wallpaper = [
        "eDP-1,/home/tako/Pictures/Wallpaper/windows-11.jpg"
      ];
    };
  };
}

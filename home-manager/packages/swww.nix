{ pkgs, ... }:
{
  home.packages = [
    pkgs.swww
  ];

  services.swww.enable = true;
}

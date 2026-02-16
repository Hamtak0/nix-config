{ pkgs, ... }:
{
  home.packages = [
    pkgs.kdePackages.qtsvg
    pkgs.kdePackages.dolphin
  ];
}

{ pkgs, ... }:
{
  home.packages = [
    pkgs.libreoffice-qt
    pkgs.hunspell
    pkgs.hunspellDicts.th_TH
  ];
}

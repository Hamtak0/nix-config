{ pkgs, ... }:
{
  home.packages = [
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
    pkgs.liberation_ttf

    pkgs.corefonts # Microsoft web fonts
    # pkgs.vista-fonts # Microsoft vista fonts
    # pkgs.googlesans-code

    pkgs.sarabun-font
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [
        "Noto Serif"
        "Noto Serif Thai"
        "Noto Serif JP"
      ];
      sansSerif = [
        "Noto Sans"
        "Noto Sans Thai"
        "Noto Sans JP"
      ];
    };
  };
}

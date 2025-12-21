{ pkgs, ... }:
{
  home.packages = [ 
  pkgs.noto-fonts 
  pkgs.noto-fonts-cjk-sans
  pkgs.noto-fonts-cjk-serif
  pkgs.noto-fonts-color-emoji
  pkgs.liberation_ttf
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [
        "Noto Serif"
        "Noto Serif Thai"
      ];
      sansSerif = [
        "Noto Sans"
        "Noto Sans Thai"
	"Noto Sans JP"
      ];
    };
  };
}

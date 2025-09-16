{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      dejavu_fonts
      freefont_ttf
      liberation_ttf
      unifont

      noto-fonts
      noto-fonts-cjk-sans
      nerd-fonts.jetbrains-mono
    ];

    fontconfig = {
      defaultFonts = {
        monospace = ["JetBrainsMono Nerd Font"];
      };
    };
  };
}

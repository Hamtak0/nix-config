{ pkgs, ...}:
let
  nerdFontsJetbrainsMono = "JetBrainsMono Nerd Font";
in
{
  home.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  fonts.fontconfig.defaultFonts.monospace = [ nerdFontsJetbrainsMono ];

  programs.foot.settings.main.font = "${nerdFontsJetbrainsMono}:size=14";
}

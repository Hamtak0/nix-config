{
  inputs,
  pkgs,
  ...
}:
let
  hyprlandPkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
    # set the flake package
    package = hyprlandPkgs.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = hyprlandPkgs.xdg-desktop-portal-hyprland;
  };
}

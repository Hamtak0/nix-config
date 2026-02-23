{
  programs.fish = {
    enable = true;

    shellAbbrs = {
      ni = "nh os switch /etc/nix-config";
      cdn = "z /etc/nix-config";
      mh = "man home-configuration.nix";
      mc = "man configuration.nix";
    };

    shellAliases = {
      cd = "z";
      ls = "eza";
      zed = "zeditor";
    };
  };
}

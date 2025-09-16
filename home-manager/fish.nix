{...}: {
  programs.fish = {
    enable = true;

    shellAbbrs = {
      ni = "nh os switch ~/Documents/nix-config";
      y = "yazi";
    };
  };
}

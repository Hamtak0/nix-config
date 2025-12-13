{...}: {
  programs.fish = {
    enable = true;

    shellAbbrs = {
      ni = "nh os switch /etc/nix-config";
      y = "yazi";
      cdn = "cd /etc/nix-config";
    };
  };
}

{ ... }:
{
  programs.fish = {
    enable = true;

    shellAbbrs = {
      ni = "nh os switch /etc/nix-config";
      y = "yazi";
      cdn = "cd /etc/nix-config";
      mh = "man home-configuration.nix";
      mc = "man configuration.nix";
    };
  };
}

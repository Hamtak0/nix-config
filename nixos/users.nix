{
  pkgs,
  ...
}: {
  users.users = {
    tako = {
      initialPassword = "horse69";
      isNormalUser = true;
      description = "hamtak0";
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = ["wheel" "video" "input" "networkmanager"];
      shell = pkgs.fish;
    };
  };
}

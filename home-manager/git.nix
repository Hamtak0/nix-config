{...}: {
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      core = {
	sshCommand = "ssh -o IdentitiesOnly=yes -i ~/.ssh/id_ed25519.github.Hamtak0";
      };
    };
  };
}

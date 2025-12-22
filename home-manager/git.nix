{...}: {
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      core = {
	sshCommand = "ssh -o IdentitiesOnly=yes -i ~/.ssh/id_ed25519.github.Hamtak0";
      };
    };
  };
}

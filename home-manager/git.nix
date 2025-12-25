{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Hamtak0";
        email = "motorfirst2547@gmail.com";
      };
      init.defaultBranch = "main";
      core = {
        sshCommand = "ssh -o IdentitiesOnly=yes -i ~/.ssh/id_ed25519.github.Hamtak0";
      };
    };
  };
}

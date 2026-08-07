{
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

  programs.seahorse.enable = true;
  programs.dconf.enable = true;

  # fix ssh overlapped
  services.gnome.gcr-ssh-agent.enable = false;
}

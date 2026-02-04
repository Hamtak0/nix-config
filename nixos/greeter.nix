{
  config,
  pkgs,
  ...
}:
let
  #tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  #hyprland-session = "${pkgs.hyprland}/share/wayland-sessions";

  custom-sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "pixel_sakura";
  };
in
{
  # sddm settings
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;

    enableHidpi = true;
    autoNumlock = true;
    theme = "sddm-astronaut-theme";
    settings = {
      Theme = {
        Current = "sddm-astronaut-theme";
      };
    };
    extraPackages = [ custom-sddm-astronaut ];
  };

  environment.systemPackages = [
    custom-sddm-astronaut
    pkgs.kdePackages.qtmultimedia
  ];

  # tuigreet settings
  #services.greetd = {
  #  enable = true;
  #  #settings = {
  #  #  default_session = {
  #  #    command = "${tuigreet} --time --remember --remember-session --sessions ${hyprland-session}";
  #  #    user = "greeter";
  #  #  };
  #  #};
  #};
  # this is a life saver.
  # literally no documentation about this anywhere.
  # might be good to write about this...
  # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
  #systemd.services.greetd.serviceConfig = {
  #  Type = "idle";
  #  StandardInput = "tty";
  #  StandardOutput = "tty";
  #  StandardError = "journal"; # Without this errors will spam on screen
  #  # Without these bootlogs will spam on screen
  #  TTYReset = true;
  #  TTYVHangup = true;
  #  TTYVTDisallocate = true;
  #};
}

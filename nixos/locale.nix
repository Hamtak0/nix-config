{
  # Select internationalisation properties.
  # Mandatory
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocales = [
    "th_TH.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
  ];

  # Optionally
  # https://wiki.archlinux.org/title/Locale
  i18n.extraLocaleSettings =
    let
      en = "en_US.UTF-8";
      jp = "ja_JP.UTF-8";
      th = "th_TH.UTF-8";
    in
    {
      # LC_ALL = "en_US.UTF-8"; # This overrides all other LC_* settings.
      LC_CTYPE = jp;
      LC_ADDRESS = th;
      LC_MEASUREMENT = th;
      LC_MESSAGES = en;
      LC_MONETARY = en;
      LC_NAME = en;
      LC_NUMERIC = en;
      LC_PAPER = en;
      LC_TELEPHONE = th;
      LC_TIME = jp;
      LC_COLLATE = en;
    };
}

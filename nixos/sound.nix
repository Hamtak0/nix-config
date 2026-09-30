{
  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;

    wireplumber.extraConfig = {
      "10-bluetooth"."monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
      };
      "11-bluetooth-policy"."wireplumber.settings" = {
        "bluetooth.autoswitch-to-headset-profile" = false;
      };
    };
  };

  security.rtkit.enable = true;
}

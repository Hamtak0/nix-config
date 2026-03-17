{ inputs, ... }:
{
  imports = [ inputs.self.nixosModules.asus-battery-limit ];

  services.asus-battery-limit = {
    enable = true;
    chargeThreshold = 80;
    batteryDevice = "BAT1";
  };
}

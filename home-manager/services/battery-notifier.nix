{ inputs, ... }:
{
  imports = [ inputs.self.homeManagerModules.battery-notifier ];

  services.battery-notifier = {
    enable = true;
    notCharging = 75;
    lowThreshold = 30;
    criticalThreshold = 20;
    batteryDevice = "BAT1";
  };
}

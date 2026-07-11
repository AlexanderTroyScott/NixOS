{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs.unstable; [
    asusctl       # ASUS keyboard/fan/backlight control
    brightnessctl # Backlight control (display + keyboard LED)
  ];

  services.asusd.enable = lib.mkDefault true;
  services.hardware.bolt.enable = lib.mkDefault true; # Thunderbolt device manager

  # Power management for laptop battery life
  services.tlp = {
    enable = lib.mkDefault true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      START_CHARGE_THRESH_BAT0 = 20;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };
}

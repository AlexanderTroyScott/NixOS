{ pkgs, ... }:
{
  environment.systemPackages = with pkgs.unstable; [
    asusctl       # ASUS keyboard/fan/backlight control
    brightnessctl # Backlight control (display + keyboard LED)
  ];

  services.asusd.enable = true;
  services.hardware.bolt.enable = true; # Thunderbolt device manager
}

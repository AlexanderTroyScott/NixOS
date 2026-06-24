{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs.unstable; [
    asusctl       # ASUS keyboard/fan/backlight control
    brightnessctl # Backlight control (display + keyboard LED)
  ];

  services.asusd.enable = lib.mkDefault true;
  services.hardware.bolt.enable = lib.mkDefault true; # Thunderbolt device manager
}

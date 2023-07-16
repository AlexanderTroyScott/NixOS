#  Specific system configuration settings for desktop
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./laptop
#   │        ├─ default.nix *
#   │        └─ hardware-configuration.nix
#   └─ ./modules
#       ├─ ./desktop
#       │   ├─ ./bspwm
#       │   │   └─ default.nix
#       │   └─ ./virtualisation
#       │       └─ docker.nix
#       └─ ./hardware
#           └─ default.nix
#

{ config, pkgs, user,  inputs, hyprland, ... }:

{
  imports =                                               # For now, if applying to other system, swap files
    [(import ./hardware-configuration.nix)] 
    #++            # Current system hardware config @ /etc/nixos/hardware-configuration.nix
    ++ [(import ./hardware-settings.nix)] #[(import ../../modules/desktop/bspwm/default.nix)] ++ # Window Manager
    #[(import ../../modules/desktop/virtualisation/docker.nix)] ++  # Docker
    #(import ../../modules/hardware);                      # Hardware devices
    ;
  boot = {                                  # Boot options
    kernelPackages = pkgs.linuxPackages_latest;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  environment = {
    systemPackages = with pkgs; [
      simple-scan
    ];
  };

  programs = {                              # No xbacklight, this is the alterantive
    dconf.enable = true;
    light.enable = true;
    hyprland = {
      enable = true;
      #nvidiaPatches = with host; if hostName == "work" then true else false;
    };
    hyprland.package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };

  services = {
    tlp.enable = true;                      # TLP and auto-cpufreq for power management
    #logind.lidSwitch = "ignore";           # Laptop does not go to sleep when lid is closed
    auto-cpufreq.enable = true;
    blueman.enable = true;
  };
}

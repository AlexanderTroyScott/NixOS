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
    ++ [(import ./hardware-settings.nix)] 
       ;
  boot = {                                  
    # Boot options
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = ["!" "thunderbolt"];
    kernelParams = [ "bolt" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = [
    pkgs.xdg-desktop-portal-hyprland
    pkgs.bolt
    #Yubikey
#    pkgs.gnupg1
 #   pkgs.pcscliteWithPolkit
 #   pkgs.yubikey-manager
 #   pkgs.pinentry
    #Touchpad
    #pkgs.xlibinput-calibrator
    pkgs.libinput
    #VPNs
    #pkgs.wireguard 
    pkgs.wireguard-tools
    pkgs.networkmanager-openvpn

  ];
   xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;

  };

  services = {
    hardware.bolt.enable = true;
    getty.autologinUser = "${user}";        #auto-login at boot
    logind.extraConfig = ''
        # Suspend then hibernate when the power key is short pressed. Long presses are handled by Bios and will power off.
        HandlePowerKey=hibernate
        HandleLidSwitch=suspend-then-hibernate
        HandleLidSwitchDocked=ignore
        HandleLidSwitchExternalPower=ignore
      '';
    pcscd.enable = true; #for yubikey but may not have worked
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    tlp.enable = true;                      # TLP and auto-cpufreq for power management
    #logind.lidSwitch = "ignore";           # Laptop does not go to sleep when lid is closed
    auto-cpufreq.enable = true;
    blueman.enable = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };
  programs = {
    dconf.enable = true;
    light.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    #sway.enable = true;
    #hyprland.package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };

  #environment.variables.GTK_THEME = "Adwaita:dark";

  
  services.github-runner.enable = true;
  services.github-runner.url = "https://github.com/AlexanderTroyScott/NixOS";
  #Token needs to have read/write Administration priviledges to create runners.
  services.github-runner.tokenFile = "/home/alex/Documents/runner.token";
  services.github-runner.replace = true;
  services.github-runner.serviceOverrides = {
    ProtectHome = false;
  };
  services.github-runner.user = "alex";
  #services.github-runner.workDir = "/home/alex/Documents/Github";
  
  environment.variables.BROWSER = "${pkgs.vivaldi}/bin/vivaldi"; #set default browser
  
  environment.sessionVariables = {
    #WLR_NO_HARDWARE_CURSORS = "1"; 
    #if cursor is invisible
    NIXOS_OZONE_WL = "1";
    #
  };

  security.pam.services.swaylock = {
    text = ''
    auth include login
    '';
  };
}

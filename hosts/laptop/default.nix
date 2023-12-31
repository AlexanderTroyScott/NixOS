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
    ++ [(import ./github-runner.nix)] 
       ;
  boot = {
    # Boot options
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = ["!" "thunderbolt"];
    kernelParams = [ "bolt" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
  #programs.hyprland.enable = true; 
  environment.systemPackages = with pkgs; [
    #rtkit
    #xdg-desktop-portal
    #xdg-desktop-portal-gtk 
    xdg-desktop-portal-hyprland
    bolt
    hyprland
    libinput
    #VPNs
    #wireguard 
    wireguard-tools
    networkmanager-openvpn

  ];
  #Ignore Wireguard related traffic
  networking.firewall = {
   # if packets are still dropped, they will show up in dmesg
   logReversePathDrops = true;
   # wireguard trips rpfilter up
   extraCommands = ''
     ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
     ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
   '';
   extraStopCommands = ''
     ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
     ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
   '';
  };

  xdg.portal = { 
     enable = true;
     xdgOpenUsePortal = true;
     extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; };

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
      audio.enable = true;
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

  environment.variables.BROWSER = "${pkgs.vivaldi}/bin/vivaldi"; #set default browser
  
  environment.sessionVariables = {
    #WLR_NO_HARDWARE_CURSORS = "1"; 
    #if cursor is invisible
    NIXOS_OZONE_WL = "1";
  };

  security.pam.services.swaylock = {
    text = ''
    auth include login
    '';
  };
}

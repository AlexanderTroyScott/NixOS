# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  hyprland,
  home-manager,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
         #./hardware/zenbook/hardware-settings.nix
          ./hardware/zenbook/hardware-configuration.nix
          #./hardware/yubikey.nix
          #./hardware/storage.nix
          ./hardware/printer.nix
          #./configs/fonts.nix

    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd



    # You can also split up your configuration and import pieces of it here:
    # ./users.nix
    #./configs/github-runner.nix

    ./configs/wireguard.nix
    ./configs/fonts.nix
    #./configs/xwayland.nix
    # Import your generated (nixos-generate-config) hardware configuration

    #Home manager
    #inputs.home-manager.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
  ];


  services.xserver.enable = true;  
  stylix = {
     enable = true;
     image =
      pkgs.fetchurl {
      url = "https://github.com/AlexanderTroyScott/NixOS/blob/main/.github/black_cat.jpeg?raw=true";
      sha256 = "8229741e8e01042330037a708462dc8243df5ff2de3c99189436a68799220f0b";
      };
     base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
     override.base00 = "000000";
     #override.base02 = "000000";
     #cursor.package = pkgs.hyprcursor;
     cursor.package = pkgs.bibata-cursors;
     cursor.name = "Bibata-Original-Classic";
     cursor.size=20;
     polarity = "dark";
     opacity = {
       applications = 1.0;
       terminal = 0.9;
       popups = 1.0;
       desktop = 1.0;
     };
     fonts = {
       sizes = {
         applications = 9;
         terminal = 9;
         popups = 9;
         desktop = 9;
       };
       serif = {
         package = pkgs.dejavu_fonts;
         name = "DejaVu Serif";
       };
       sansSerif = {
         package = pkgs.dejavu_fonts;
         name = "DejaVu Sans";
       };
       monospace = {
         name = "Fira Code";
         package = pkgs.fira-code;
       };
       emoji = {
         package = pkgs.fira-code-symbols;
         name = "Fira Code Emoji";
       };
      };
    };

  
  #services.avahi.enable = true;
  #services.avahi.nssmdns = true;

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
services.flatpak.enable = true;
virtualisation.docker.enable = true;
environment.systemPackages = with pkgs.unstable; [
      inputs.zen-browser.packages."${system}".default
      libva
      libva-utils            # Video Acceleration Info (intel)
      git              # Repositories
      pciutils         # Computer Utility Info
      pipewire         # Sound
      usbutils         # USB Utility Info
      wget             # Downloader
      dunst            # Notifications
      libnotify        # Dependency for Dunst
      glxinfo          # Get graphics card info
      neofetch
      vdhcoapp #Firefox downloader extension
      # Menu
      mpd
      rofi-power-menu  # Power Menu
      #udiskie          # Auto Mounting
      #xorg.xrandr      # Screen Settings
      #xorg.xinit
      #xorg.xorgserver
      autotiling       # Tiling Script
      grim             # Image Grabber
      slurp            # Region Selector
      wev              # Input Viewer
      wl-clipboard     # Console Clipboard
      wlr-randr        # Screen Settings
      pamixer          # Pulse Audio Mixer
      networkmanagerapplet
      blueman          # Bluetooth
      cbatticon        # Battery Notifications
      light            # Display Brightness
      wireguard-tools
      lshw
      udiskie
      zed-editor
      cifs-utils #SMB/CIFS share for unraid
      libsecret #for keyring remembering secrets
      popsicle
    ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  #Gnome Keyring
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.lightdm.enableGnomeKeyring = true;
  #ssh.startAgent = true;

  services.upower.enable = true;
 
  security.pam.services.swaylock = {
    text = ''
    auth include login
   '';
  };


  environment.sessionVariables = {
    #WLR_NO_HARDWARE_CURSORS = "1";
    #if cursor is invisible
    NIXOS_OZONE_WL = "1"; #Needed for cursor to not be pixilated over xwayland apps
  };
  networking.networkmanager.enable = true;

  programs.hyprland = {
    enable = true;
  };

}

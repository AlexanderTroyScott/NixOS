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
  catppuccin,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
         ./hardware/mi-book/hardware-settings.nix
          ./hardware/mi-book/hardware-configuration.nix
          #./hardware/yubikey.nix
          ./hardware/storage.nix
          ./hardware/printer.nix
          ./configs/fonts.nix
         
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
    ./configs/xwayland.nix
    # Import your generated (nixos-generate-config) hardware configuration

    #Home manager
    #inputs.home-manager.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
  ];
#services.xserver.enable = false;

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };
  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
    gc = {                                  # Automatic garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  #Timezone and Keyboard
  time.timeZone = "America/Chicago";
  #time.timeZone = "Europe/London";
  services.timesyncd.enable = true;
  #services.automatic-timezoned.enable = true;
  #services.timesyncd.enable = true;
  #services.geoclue2.enable = true;
  #services.avahi.enable = true;
  #services.avahi.nssmdns = true;
  #Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
services.flatpak.enable = true;
virtualisation.docker.enable = true;
environment.systemPackages = with pkgs.unstable; [
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
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xdg-utils
      wireguard-tools
      lshw
      udiskie
      zed-editor
      cifs-utils #SMB/CIFS share for unraid
      #bolt
      #networkmanager-openvpn
      libsecret #for keyring remembering secrets
      popsicle
      #catppuccin-cursors.latteDark
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
  xdg.portal.config.common.default = "*"; #https://github.com/flatpak/xdg-desktop-portal/blob/1.18.1/doc/portals.conf.rst.in
  programs.hyprland = {
    enable = true;
    xwayland = {
      #enable = false;
      enable=true;
      #hidpi = true;
    };
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
  security.pam.services.swaylock = {
    text = ''
    auth include login
   '';
  };

  networking.networkmanager.enable = true;
  # TODO: This is just an example, be sure to use whatever bootloader you prefer
  boot.loader.systemd-boot.enable = true;

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # FIXME: Replace with your username
    alex = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "wheel" "networkmanager" "video" "audio" "camera" "input" "docker" "storage"];
    };
  };

networking.extraHosts = ''
  192.168.190.196:8006 proxmox.lan
'';
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}

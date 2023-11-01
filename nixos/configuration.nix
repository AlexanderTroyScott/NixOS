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
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix
    ./configs/github-runner.nix
    ./configs/hardware-settings.nix
    ./configs/wireguard.nix
    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    #Home manager
    #inputs.home-manager.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      # Import your home-manager configuration
      alex = import ../home-manager/home.nix;
    };
  };

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
      permittedInsecurePackages = [
        "nodejs-16.20.2"
      ];
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
environment.systemPackages = with pkgs; [
      # Terminal
      btop              # Resource Manager
      ranger            # File Manager
      kitty
      unzip
      feh               # Image Viewer
      pavucontrol       # Audio Control
      vlc               # Media Player
      pinta             # Image editor
      #qt5.qtwayland
      #qt6.qtwayland
      #libsForQt5.qtinstaller
      #libsForQt5.audiotube
      vivaldi
      vscode
      #gnome.file-roller # Archive Manager
      okular            # PDF Viewer
      pcmanfm           # File Manager
      cinnamon.nemo     # File Manager
      p7zip             # Zip Encryption
      rsync             # Syncer - $ rsync -r dir1/ dir2/
      unzip             # Zip Files
      unrar             # Rar Files
      zip               # Zip
      libva
      libva-utils            # Video Acceleration Info (intel)
      git              # Repositories
      pciutils         # Computer Utility Info
      pipewire         # Sound
      usbutils         # USB Utility Info
      wget             # Downloader
      openvpn
      dunst            # Notifications
      libnotify        # Dependency for Dunst
      glxinfo           # Get graphics card info
      neofetch
      wofi
      rofi             # Menu
      mpd
      rofi-power-menu  # Power Menu
      #udiskie          # Auto Mounting
      #xorg.xrandr      # Screen Settings
      #xorg.xinit
      #xorg.xorgserver
      autotiling       # Tiling Script
      grim             # Image Grabber
      slurp            # Region Selector
      swayidle         # Idle Management Daemon
      wev              # Input Viewer
      wl-clipboard     # Console Clipboard
      wlr-randr        # Screen Settings
      pamixer          # Pulse Audio Mixer
      #swaybg           # Background
      #swaylock-fancy   # Screen Locker
      waybar           # Bar
      hyprpaper
      swaylock-effects
      networkmanagerapplet
      blueman          # Bluetooth
      deluge           # Torrents
      discord          # Chat
      betterdiscordctl
      #prismlauncher    # MC Launcher
      steam            # Games
      #xterm            # Terminal
      cbatticon        # Battery Notifications
      blueman          # Bluetooth
      light            # Display Brightness
      obsidian
      #logseq          # Uses electron-24.8.6 which is insecure, waiting for update
      libreoffice      # Office Tools
      firefox
      #xdg-desktop-portal-hyprland
      wireguard-tools
      #bolt
      #libinput 
      #networkmanager-openvpn 
    ];
  # FIXME: Add the rest of your current configuration
  #security.pam.services.swaylock = {};
  programs.hyprland = {
    enable = true;  
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;  
  };



  # TODO: Set your hostname
  networking.hostName = "MiBook";

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
      extraGroups = [ "wheel" "networkmanager" "video" "audio" "camera" "input" "docker"];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}

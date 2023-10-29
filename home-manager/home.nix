# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  hyprland,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
    #inputs.hyprland.nixosModules.default
    inputs.hyprland.homeManagerModules.default
    # You can also split up your configuration and import pieces of it here:
    ./hyprland.nix
    ./kitty.nix
    ./swayidle.nix
    ./waybar.nix
  ];

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
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: Set your username
  home = {
    username = "alex";
    homeDirectory = "/home/alex";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  #home.packages = with pkgs; [ hyprland ];
  home.packages = with pkgs; [
      # Terminal
      btop              # Resource Manager
      ranger            # File Manager
      #tldr              # Helper
      kitty
      unzip
      # Video/Audio
      feh               # Image Viewer
      #mpv               # Media Player
      pavucontrol       # Audio Control
      #plex-media-player # Media Player
      #vlc               # Media Player
      #stremio           # Media Streamer
      pinta             # Image editor
      qt5.qtwayland
      qt6.qtwayland
      libsForQt5.qtinstaller
      libsForQt5.audiotube
      # Apps
      #appimage-run      # Runs AppImages on NixOS
      #firefox           # Browser
      #google-chrome     # Browser
      #remmina           # XRDP & VNC Client
      #ib-tws            # Trading
      vivaldi
      vscode
      # File Management
      gnome.file-roller # Archive Manager
      okular            # PDF Viewer
      pcmanfm           # File Manager
      cinnamon.nemo     # File Manager
      p7zip             # Zip Encryption
      rsync             # Syncer - $ rsync -r dir1/ dir2/
      unzip             # Zip Files
      unrar             # Rar Files
      zip               # Zip
      
      libva-utils            # Video Acceleration Info (intel)
      # General configuration
      git              # Repositories
      github-runner
      
      #killall          # Stop Applications
      #nano             # Text Editor
      pciutils         # Computer Utility Info
      pipewire         # Sound
      usbutils         # USB Utility Info
      #wacomtablet      # Wacom Tablet
      wget             # Downloader
      #zsh              # Shell
      openvpn
      #
      # General home-manager
      #alacritty        # Terminal Emulator
      dunst            # Notifications
      #doom emacs       # Text Editor
      libnotify        # Dependency for Dunst
      #neovim           # Text Editor
      glxinfo           # Get graphics card info
      neofetch
      wofi
      rofi             # Menu
      mpd
      rofi-power-menu  # Power Menu
      udiskie          # Auto Mounting
      #vim              # Text Editor
      #
      # Xorg configuration
      #xclip            # Console Clipboard
      #xorg.xev         # Input Viewer
      #xorg.xkill       # Kill Applications
      xorg.xrandr      # Screen Settings
      #xterm            # Terminal
      xorg.xinit
      xorg.xorgserver

      #
      # Xorg home-manager
      #flameshot        # Screenshot
      #picom            # Compositer
      #sxhkd            # Shortcuts
      #
      # Wayland configuration
      autotiling       # Tiling Script
      grim             # Image Grabber
      slurp            # Region Selector
      #swappy           # Screenshot Editor
      swayidle         # Idle Management Daemon
      wev              # Input Viewer
      wl-clipboard     # Console Clipboard
      wlr-randr        # Screen Settings
      #xwayland         # X for Wayland
      #
      # Wayland home-manager
      #mpvpaper         # Video Wallpaper
      pamixer          # Pulse Audio Mixer
      #swaybg           # Background
      #swaylock-fancy   # Screen Locker
      waybar           # Bar
      hyprpaper
      swaylock-effects
      networkmanagerapplet
      # Desktop
      #ansible          # Automation
      blueman          # Bluetooth
      deluge           # Torrents
      discord          # Chat
      betterdiscordctl

      #ffmpeg           # Video Support (dslr)
      #gmtp             # Mount MTP (GoPro)
      #gphoto2          # Digital Photography
      #handbrake        # Encoder
      #heroic           # Game Launcher
      #hugo             # Static Website Builder
      #lutris           # Game Launcher
      #mkvtoolnix       # Matroska Tool
      #nvtop            # Videocard Top
      #plex-media-player# Media Player
      prismlauncher    # MC Launcher
      steam            # Games
      xterm            # Terminal
      
      #simple-scan      # Scanning
      #sshpass          # Ansible dependency
      # 
      # Laptop
      cbatticon        # Battery Notifications
      blueman          # Bluetooth
      light            # Display Brightness
      obsidian
      logseq
      libreoffice      # Office Tools
      #simple-scan      # Scanning
      firefox
      #
      # Flatpak
      #obs-studio       # Recording/Live Streaming
    ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}

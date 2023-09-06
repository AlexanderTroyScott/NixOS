#
#  General Home-manager configuration
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ home.nix *
#   └─ ./modules
#       ├─ ./programs
#       │   └─ default.nix
#       └─ ./services
#           └─ default.nix
#

{ config, lib, pkgs, unstable, user, ... }:

{ 
  #imports =                                   # Home Manager Modules
    #(import ../modules/programs) ++
    #(import ../modules/services);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    
    packages = with pkgs; [
      # Terminal
      btop              # Resource Manager
      ranger            # File Manager
      #tldr              # Helper
      kitty

      # Video/Audio
      feh               # Image Viewer
      #mpv               # Media Player
      pavucontrol       # Audio Control
      #plex-media-player # Media Player
      #vlc               # Media Player
      #stremio           # Media Streamer
      pinta             # Image editor
    

      # Apps
      #appimage-run      # Runs AppImages on NixOS
      #firefox           # Browser
      #google-chrome     # Browser
      #remmina           # XRDP & VNC Client
      #ib-tws            # Trading
      vivaldi

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
      #simple-scan      # Scanning
      #sshpass          # Ansible dependency
      # 
      # Laptop
      cbatticon        # Battery Notifications
      blueman          # Bluetooth
      light            # Display Brightness
      #libreoffice      # Office Tools
      #simple-scan      # Scanning
      firefox
      #
      # Flatpak
      #obs-studio       # Recording/Live Streaming
    ];

    stateVersion = "23.05";
  };

  programs = {
    home-manager.enable = true;
  };
}

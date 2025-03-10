# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
let
  cursorSize = 28;
in
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  catppuccin,
  #hyprland,
  #home-manager,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example
    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
    #inputs.hyprland.nixosModules.default
    #inputs.hyprland.homeManagerModules.default
    # You can also split up your configuration and import pieces of it here:

    ./kitty.nix
    ./waybar.nix
    ./fuzzel.nix
    ./hypr/hyprland.nix
    ./hypr/hyprlock.nix
    ./hypr/hypridle.nix
    ./hypr/hyprpaper.nix
    ./hypr/hyprcursor.nix
    ./vscode.nix
    ./theme/icons.nix
   # ./theme/catppuccin.nix
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
  #services.polkit.enable = true;
 nixpkgs.config.permittedInsecurePackages = [
                "electron-25.9.0"
              ];
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = with pkgs; [
    #libnotify
    #programs
    github-desktop
    coder
    #insync
    rsync
plexamp
#plex-desktop
   # wootility
    btop              # Resource Manager
    ranger            # File Manager
    unzip
    feh               # Image Viewer
    pavucontrol       # Audio Control
    vlc               # Media Player
    pinta             # Image editor
    vesktop           #discord
    #discord           # Chat
    #betterdiscordctl  # Discord Themes
    #youtube-music
    #element-desktop
    #element-web
    vivaldi
    #masterpdfeditor
    teams-for-linux
    firefox
    deluge
    vdhcoapp #firefox video downloader extension
               # Torrents
    steam            # Games
  # Required libraries for Proton
  libglvnd
  vulkan-loader
 vulkan-tools
  # Additional graphics drivers, if needed
  mesa
    gamescope
    lutris
    wine-wayland
    siyuan
    #obsidian
    #logseq          # electron-24.8.6 which is insecure, waiting for update
    #libreoffice      # Office Tools
    okular            # PDF Viewer
    #pcmanfm           # File Manager
    p7zip             # Zip Encryption
    rsync             # Syncer - $ rsync -r dir1/ dir2/
    unzip             # Zip Files
    unrar             # Rar Files
    zip               # Zip
    proton-pass
    nerd-fonts.symbols-only #Symbols for waybar/etc.
    softmaker-office
    fuzzel
    clipse  #clipboard manager              https://github.com/savedra1/clipse?tab=readme-ov-file
    #Utilities

    google-chrome
    dnsutils
    #moonlight-embedded
    #moonlight-qt
    powertop
    dive
    baobab
    #warp-terminal
    #gparted
    docker
    #distrobox
    rclone
    rclone-browser
    traceroute
    #wineWowPackages.waylandFull
    #QT5 and QT6 packages
    #qt5.qtwayland
    #qt6.qtwayland
    #libsForQt5.qt5ct
    #libsForQt5.dolphin
    #libsForQt5.qtinstaller
    #libsForQt5.audiotube
    #adwaita-qt #qt theme
    #cosmic-files
    #cosmic-term
    #cosmic-icons
    #cosmic-greeter
    #cosmic-session
    #cosmic-edit
    #cava
    dysk
    #CINNAMON APPs
    nemo     # File Manager
    yt-dlg
    xreader
    xviewer
    pix
    #nodejs_22
    #nodejs
    #nodePackages.bower
    ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;


  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";



 #xdg.mimeApps = {
 #   enable = true;
 #   associations.added = {
 #     "text/html" = [ "vivaldi-stable.desktop" ];
 #     "text/xml" = [ "vivaldi-stable.desktop" ];
 #     "x-scheme-handler/http" = [ "vivaldi-stable.desktop" ];
 #     "x-scheme-handler/https" = [ "vivaldi-stable.desktop" ];
 #   };
 #   defaultApplications = {
 #     "text/html" = [ "vivaldi-stable.desktop" ];
 #     "text/xml" = [ "vivaldi-stable.desktop" ];
 #     "x-scheme-handler/http" = [ "vivaldi-stable.desktop" ];
 #     "x-scheme-handler/https" = [ "vivaldi-stable.desktop" ];
 #   };
 # };

  #home.pointerCursor = {
  #  package = pkgs.catppuccin-cursors.latteDark;
  #  name = "Catppuccin-Latte-Dark-Cursors";
  #  size = cursorSize;
  #  gtk.enable = true;
  #};
   #gtk = {
    #enable = true;
    #font.name = "TeX Gyre Adventor 10";
    #theme = {
    #  name = "Juno";
    #  package = pkgs.juno-theme;
    #};
    #iconTheme = {
    #  package = (pkgs.catppuccin-papirus-folders.override { flavor = "mocha"; accent = "lavender"; });
    #  name  = "Papirus-Dark";
    #};
    #gtk3.extraConfig = {
    #  gtk-application-prefer-dark-theme=1;
    #  gtk-cursor-theme-size = cursorSize;
    #};
    #gtk4.extraConfig = {
    #  gtk-application-prefer-dark-theme=1;
    #  gtk-cursor-theme-size = cursorSize;
    #};
   #};
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}

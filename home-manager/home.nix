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
    ./hyprland.nix
    ./kitty.nix
    ./swayidle.nix
    ./waybar.nix
    ./fuzzel.nix
    ./hyprpaper.nix
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
 nixpkgs.config.permittedInsecurePackages = [
                "electron-25.9.0"
              ];
  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];
  home.packages = with pkgs; [ 
    #libnotify
    #programs
    insync
    btop              # Resource Manager
    ranger            # File Manager
    unzip
    feh               # Image Viewer
    pavucontrol       # Audio Control
    vlc               # Media Player
    pinta             # Image editor
    discord           # Chat
    betterdiscordctl  # Discord Themes
    youtube-music
    vivaldi
    firefox
    vscode
    deluge           # Torrents
    steam            # Games
    waybar           # Bar
    lutris
    wine-wayland
    hyprpaper
    #obsidian
    appflowy
    #logseq          # Uses electron-24.8.6 which is insecure, waiting for update
    libreoffice      # Office Tools
    okular            # PDF Viewer
    pcmanfm           # File Manager
    cinnamon.nemo     # File Manager
    p7zip             # Zip Encryption
    rsync             # Syncer - $ rsync -r dir1/ dir2/
    unzip             # Zip Files
    unrar             # Rar Files
    zip               # Zip
    #trilium-desktop
    #parsec-bin
    pcloud
    fuzzel
    anytype
    #Utilities
    dnsutils
    moonlight-qt
    obs-studio
    xplorer
    powertop
    dive # discover docker images
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
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.latteDark;
    name = "Catppuccin-Latte-Dark-Cursors";
    size = cursorSize;
    gtk.enable = true;
  };
   gtk = {
    enable = true;
    font.name = "TeX Gyre Adventor 10";
    theme = {
      name = "Juno";
      package = pkgs.juno-theme;
    };
    iconTheme = {
      package = (pkgs.catppuccin-papirus-folders.override { flavor = "Mocha"; accent = "lavender"; });
      name  = "Papirus-Dark";
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme=1;
      gtk-cursor-theme-size = cursorSize;
    };
    gtk4.extraConfig = {      
      gtk-application-prefer-dark-theme=1;
      gtk-cursor-theme-size = cursorSize;
    };
   };
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}

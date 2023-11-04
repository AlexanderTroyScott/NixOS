# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
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
  home.packages = with pkgs; [ 
    #libnotify
    #programs
    btop              # Resource Manager
    ranger            # File Manager
    unzip
    feh               # Image Viewer
    pavucontrol       # Audio Control
    vlc               # Media Player
    pinta             # Image editor
    discord          # Chat
    betterdiscordctl # Discord Themes
    youtube-music
    vivaldi
    firefox
    vscode
    deluge           # Torrents
    steam            # Games
    waybar           # Bar
    hyprpaper
    obsidian
    #logseq          # Uses electron-24.8.6 which is insecure, waiting for update
    libreoffice      # Office Tools
    #File management
    #gnome.file-roller # Archive Manager
    okular            # PDF Viewer
    pcmanfm           # File Manager
    cinnamon.nemo     # File Manager
    p7zip             # Zip Encryption
    rsync             # Syncer - $ rsync -r dir1/ dir2/
    unzip             # Zip Files
    unrar             # Rar Files
    zip               # Zip
    ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;
  
  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

 xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/pdf" = ["org.gnome.Evince.desktop"];
      "x-scheme-handler/http" = "vivaldi.desktop";
      "x-scheme-handler/https" = "vivaldi.desktop";
    };
    defaultApplications = {
      "application/pdf" = ["org.gnome.Evince.desktop"];
      "x-scheme-handler/http" = "vivaldi.desktop";
      "x-scheme-handler/https" = "vivaldi.desktop";
    };
  };
   gtk = {
      enable = true;
      font.name = "TeX Gyre Adventor 10";
      theme = {
        name = "Juno";
        package = pkgs.juno-theme;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

      gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
   };






   
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}

# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
let
  cursorSize = 20;
in
  {
    inputs,
    outputs,
    lib,
    config,
    pkgs,
    catppuccin,
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
      #./waybar.nix
      ./fuzzel.nix
      ./hypr/hyprland.nix
      ./hypr/monitors.nix
      ./hypr/hyprlock.nix
      ./hypr/hypridle.nix
      ./hypr/hyprpaper.nix
      #./hypr/hyprpanel.nix
      ./hypr/hyprcursor.nix
      ./vscode.nix
      ./waybar.nix
    ];

    nixpkgs = {
      # Bring in the flake's overlays so custom packages (pkgs/) and
      # pkgs.unstable.* are available in home.packages too
      overlays = [
        outputs.overlays.additions
        outputs.overlays.modifications
        outputs.overlays.unstable-packages
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
      "pnpm-10.29.2"
      "electron-40.10.5"
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
      plexamp
      #plex-desktop
      wootility
      eye-of-zomm # EverQuest Legends companion (EQLWiki) - pin bumped with `nix run .#update-eoz`
      btop # Resource Manager
      ranger # File Manager
      brillo
      feh # Image Viewer
      pavucontrol # Audio Control
      vlc # Media Player
      qsynth # FluidSynth GUI (MIDI for Steam games)
      soundfont-fluid # FluidR3 GM SoundFont
      pinta # Image editor
      vesktop #discord
      #discord           # Chat
      #betterdiscordctl  # Discord Themes
      whatsapp-electron # WhatsApp
      #youtube-music
      #element-desktop
      #element-web
      vivaldi
      #masterpdfeditor
      teams-for-linux
      firefox
      deluge
      aria2 # Download Manager
      #vdhcoapp #firefox video downloader extension
      # Torrents
      steam # Games
      # Required libraries for Proton
      libglvnd
      vulkan-loader
      vulkan-tools
      # Additional graphics drivers, if needed
      mesa
      gamescope
      #lutris
      wine-wayland
      siyuan
      #libreoffice      # Office Tools
      #okular            # PDF Viewer
      #pcmanfm           # File Manager
      file-roller # GUI Archive Manager (for Nemo)
      p7zip # Zip Encryption
      rsync # Syncer - $ rsync -r dir1/ dir2/
      unzip # Zip Files
      unrar # Rar Files
      zip # Zip
      proton-pass
      nerd-fonts.symbols-only #Symbols for waybar/etc.
      #softmaker-office
      onlyoffice-desktopeditors
      clipse #clipboard manager              https://github.com/savedra1/clipse?tab=readme-ov-file
      #Utilities
      htop
      zoom-us
      google-chrome
      #antigravity-fhs
      dnsutils
      #moonlight-embedded
      moonlight-qt
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
      cava
      dysk
      #CINNAMON APPs
      nemo # File Manager
      yt-dlg
      xreader
      xviewer
      julia
      gh
      stirling-pdf-desktop

      #Development
      flutter #bundles the Dart SDK
      curl
      which
      xz
      file
      pkg-config
      cmake
      ninja
      clang

      #pix
    ];

    # Enable home-manager and git
    programs.home-manager.enable = true;
    #gtk.gtk4.theme = config.gtk.theme;

    programs.git = {
      enable = true;
      signing.format = null;
      settings = {
        user.name = "AlexanderTroyScott";
        user.email = "Alexander.Troy.Scott@gmail.com";
        # Git credential helper backed by gh's token in the keyring (equivalent to `gh setup-git`)
        credential."https://github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential";
      };
    };

    services.kanshi = {
      enable = false;
    };

    # Nemo bookmarks (replaces ~/.config/gtk-3.0/bookmarks — GUI-added bookmarks won't persist)
    xdg.configFile."gtk-3.0/bookmarks".text = ''
      file:///unraid/vault/tax Tax
      nfs://192.168.2.2/mnt/ssd/vault/tax Tax (Network)
    '';

    # YubiKey U2F registration — replace with output of `pamu2fcfg` after rebuilding
    xdg.configFile."Yubico/u2f_keys".text = ''
      alex:zfdSit8q1sJK5468T4Q/t1smgbTtHuIPIOSZ4rT/yZliznDtfHKdMSDzfrhGYSVHrsXKxebP0qPS5F0rpdBtZQ==,dQTbDDeMUvqGiYvgFDBkPTb6xDhZJR39jr67fnAQVHA5NBdYlvN+F950q9p0WDDm2iphTkN8Jxcipdj2uxUUtg==,es256,+presence
    '';

    # Qsynth config — use PulseAudio driver (via PipeWire) instead of JACK
    xdg.configFile."qsynth/qsynth.conf".text = ''
      [Audio]
      AudioDriver=pulseaudio
    '';

    # EverQuest MIDI music via FluidSynth + PipeWire
    systemd.user.services.eq-midi = {
      Unit = {
        Description = "EverQuest FluidSynth MIDI via PipeWire";
        After = ["pipewire.service"];
      };
      Service = {
        ExecStart = "${pkgs.fluidsynth}/bin/fluidsynth -is -a pulseaudio ${pkgs.soundfont-fluid}/share/soundfonts/FluidR3_GM2-2.sf2";
        Restart = "on-failure";
        RestartSec = 2;
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };

    # Nicely reload system units when changing configs
    # systemd.user.startServices = "sd-switch";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.05";
  }

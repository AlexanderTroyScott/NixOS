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
  imports = [];


  services.xserver.enable = true;  
  stylix = {
     enable = true;
     #to get sha256 run: curl -L 'https://raw.githubusercontent.com/AlexanderTroyScott/NixOS/main/.github/omori-aubrey.gif' | sha256sum
     image =
      pkgs.fetchurl {
      url = "https://github.com/AlexanderTroyScott/NixOS/blob/main/.github/raven.jpg?raw=true";
      sha256 = "ba4cf84f018203f809a3f67615c4b991858a6c7d7ec4f882e945679bff7aa795";
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
#services.flatpak.enable = true;
environment.systemPackages = with pkgs.unstable; [
      inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
      libva
      libva-utils            # Video Acceleration Info (intel)
      git              # Repositories
      pciutils         # Computer Utility Info
      pipewire         # Sound
      usbutils         # USB Utility Info
      wget             # Downloader
      dunst            # Notifications
      libnotify        # Dependency for Dunst
      mesa-demos       # Get graphics card info
      opencode
      #vdhcoapp #Firefox downloader extension
      # Menu
      #mpd
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
      hyprpanel
      claude-code
      claude-monitor
      blueman          # Bluetooth
      cbatticon        # Battery Notifications
      #light            # Display Brightness
      wireguard-tools
      lshw
      udiskie
      zed-editor
      cifs-utils #SMB/CIFS share for unraid
      libsecret #for keyring remembering secrets
      popsicle
      alsa-utils
      libxml2
      lxqt.lxqt-policykit #polkit, for popsicle in hyprland
    ];

      hardware = {
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
    flipperzero.enable = true;
  };

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
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "alex";
  environment.sessionVariables = {
    #WLR_NO_HARDWARE_CURSORS = "1";
    #if cursor is invisible
    NIXOS_OZONE_WL = "1"; #Needed for cursor to not be pixilated over xwayland apps
  };
  programs.hyprland = {
    enable = true;
  };


}

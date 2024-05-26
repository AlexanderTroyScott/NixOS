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
    #./configs/github-runner.nix
    #./configs/hardware-settings.nix
    #./configs/wireguard.nix
    #./configs/xwayland.nix
    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration-vm-gpu.nix
    ./configs/steam.nix
    ./configs/sunshine.nix
    ./storage.nix
    #Home manager
    #inputs.home-manager.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
  ];

  services.getty.autologinUser = "alex";
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      alex = import ../home-manager/home.nix;
    };
  };
  boot = {
    # Boot options
    kernelPackages = pkgs.linuxPackages_latest;
    #kernelPackages = pkgs.linuxKernel.packages.linux_6_5;
    kernelModules = [
       "thunderbolt" 
        "uinput"
    ];
    kernelParams = [ 
   #    "bolt" 
       "i915.force_probe=56a0" 
    ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
 hardware.enableAllFirmware = true;
#services.xserver.enable = false;
 
hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
        extraPackages = with pkgs; [
          intel-media-driver        #GPU acceleration 
          intel-compute-runtime     #OpenComputeLanguage
          intel-ocl                 #OpenComputeLanguage
          intel-vaapi-driver
          #libvdpau-va-gl
          ];
    };


  #hardware.enableRedistributableFirmware = lib.mkDefault true;

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
      options = "--delete-older-than 30d";
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

 # security.pam.services.swaylock = {};

environment.systemPackages = with pkgs; [
  qt5.qtwayland
  qt6.qtwayland
  git              # Repositories
  pciutils         # Computer Utility Info
  pipewire         # Sound
  usbutils         # USB Utility Info
  wget             # Downloader
  openvpn
  dunst            # Notifications
  libnotify        # Dependency for Dunst
  glxinfo          # Get graphics card info
  neofetch
  kitty
  # Menu
  mpd
  rofi-power-menu  # Power Menu
  #udiskie          # Auto Mounting
  autotiling       # Tiling Script
  grim             # Image Grabber
  slurp            # Region Selector
  wev              # Input Viewer
  wl-clipboard     # Console Clipboard
  wlr-randr        # Screen Settings
  #pamixer          # Pulse Audio Mixer
  networkmanagerapplet
  blueman          # Bluetooth
  light            # Display Brightness
  wireguard-tools
  #intel-vaapi-driver
  libva-utils
  libva
  wayland
  sunshine
  steam
  avahi
  mesa
  xorg.libXrandr
  sway
  xorg.xrandr
  libglvnd
  libva-utils # This provides vainfo
  # FFmpeg with hardware acceleration support
  ffmpeg-full # or another variant that supports hardware encoding
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg_utils
  ];
xdg.portal = { 
  enable = true; 
  extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; 
};
  services.blueman.enable = true;
  hardware = {
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };
  environment.variables.BROWSER = "${pkgs.vivaldi}/bin/vivaldi"; #set default browser
    services.pipewire = {
      enable = true;
      audio.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      #pulse.enable = true;
      jack.enable = true;
    };
services.upower.enable = true;

xdg.portal.config.common.default = "*"; #https://github.com/flatpak/xdg-desktop-portal/blob/1.18.1/doc/portals.conf.rst.in 
# FIXME: Add the rest of your current configuration

security.pam.services.swaylock = {
  text = ''
  auth include login
  '';
};

programs.nix-ld.enable=true;
programs.mtr.enable=true;
programs.gnupg.agent = {
  enable=true;
  enableSSHSupport = true;
};

fonts= {
  packages = with pkgs; [                # Fonts
    carlito                                 # NixOS
    vegur                                   # NixOS
    source-code-pro
    jetbrains-mono
    font-awesome                            # Icons
    corefonts                               # MS
    # nerdfonts
      (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
  ];};

  # Font configuration
  fonts.fontconfig.defaultFonts = {
    monospace = [ "FiraCode" ];
    sansSerif = [ "FiraCode" ];
    serif = [ "FiraCode" ];
    #monospace = [ "FiraCode" ];
    emoji =[ "FiraCode" ];
    #monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
    #emoji = ["Noto Color Emoji"];
  };

  # TODO: Set your hostname
  networking.hostName = "VM-GPU";
  networking.networkmanager.enable = true;

  environment.variables = {
    VM_GPU = "true";
  };

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
 
 #programs.sway.enable = true;
  networking.firewall.enable=false;
  services.openssh.enable=true;
networking.extraHosts = ''
  192.168.190.196:8006 proxmox.actuary.dev
'';
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}

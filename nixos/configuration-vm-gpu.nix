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
  boot = {
    # Boot options
    kernelPackages = pkgs.linuxPackages_testing;
    kernelModules = ["!" "thunderbolt" "uinput"];
    #kernelParams = [ "bolt" "i915.force_probe=56a0" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
  services.avahi.publish.userServices = true;
  hardware = {
    opengl.enable = true;
  };
  hardware.opengl.driSupport32Bit = true;
  hardware.steam-hardware.enable = true;
  #Intel CPU opencl support
  hardware.opengl.extraPackages = with pkgs; [
  intel-media-driver        #GPU acceleration 
  intel-compute-runtime     #OpenComputeLanguage
  intel-ocl                 #OpenComputeLanguage
  ];
  hardware.enableRedistributableFirmware = lib.mkDefault true;
  services.xserver.enable = false;
  #services.xserver.autorun = false;

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

 # security.pam.services.swaylock = {};

environment.systemPackages = with pkgs; [
      qt5.qtwayland
      qt6.qtwayland
      #libsForQt5.qtinstaller
      #libsForQt5.audiotube

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
      blueman          # Bluetooth
      light            # Display Brightness
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xdg_utils
      wireguard-tools
      sunshine
        # For Intel/AMD
  libva-utils # This provides vainfo
  # FFmpeg with hardware acceleration support
  ffmpeg-full # or another variant that supports hardware encoding
      #bolt
      #networkmanager-openvpn
    ];
  xdg.portal = { 
    enable = true; 
    #extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; 
  };
  services.upower.enable = true;
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk  ];
  #xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk  ];
  xdg.portal.config.common.default = "*"; #https://github.com/flatpak/xdg-desktop-portal/blob/1.18.1/doc/portals.conf.rst.in 
  # FIXME: Add the rest of your current configuration
  programs.hyprland = {
    enable = true;  
    package = inputs.hyprland.packages.${pkgs.system}.hyprland; 
  };
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
  networking.firewall.enable=false;
  services.openssh.enable=true;
networking.extraHosts = ''
  192.168.190.196:8006 proxmox.actuary.dev
'';
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
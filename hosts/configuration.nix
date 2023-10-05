# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, lib, pkgs, inputs, user, ... }:

{
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "camera" "input" "docker"]; # Enable ‘sudo’ for the user.
 #   packages = with pkgs; [
   #   steam
  #    discord
 #     pcloud
      #vivaldi
#      vscode
  #  ];
  };
  
  environment.systemPackages = with pkgs; [
  # ... other packages
  docker
  ];
  virtualisation.docker.enable = true;
  #virtualisation.docker.storageDriver = "btrfs";
  virtualisation.docker.rootless = {
  enable = true;
  setSocketVariable = true;
  };
  networking.networkmanager.enable = true;
  security.pam.services.swaylock = {};
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
  ];
      # causes more issues than it solves
    enableDefaultPackages = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = ["Roboto Serif" "Noto Color Emoji"];
      sansSerif = ["Roboto" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

#Timezone and Keyboard
  #time.timeZone = "America/Chicago";
  #time.timeZone = "Europe/London";
  services.automatic-timezoned.enable = true;
  services.timesyncd.enable = true;
  services.geoclue2.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
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

  # Enable the X11 windowing system.
#  services.xserver = {
#    enable = true;
    #displayManager.gdm.wayland.enable = true;
    #displayManager.gdm = {
    #    enable = true;
    #    wayland = true;
    #};
#};

  nix = {                                   # Nix Package Manager settings
    settings ={
      auto-optimise-store = true;           # Optimise syslinks
    };
    gc = {                                  # Automatic garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixVersions.unstable;    # Enable nixFlakes on system
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  
  nixpkgs.config = {
    # Allow non-free packages
    allowUnfree = true;

    permittedInsecurePackages = [
      "nodejs-16.20.2"
    ];
  };

  system = {                                # NixOS settings
    #autoUpgrade = {                         # Allow auto update (not useful in flakes)
    #  enable = true;
    #  channel = "https://nixos.org/channels/nixos-unstable";
    #};
    stateVersion = "23.05";
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
}


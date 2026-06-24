{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./docker.nix
    ./storage.nix
    ./github-runner.nix
    # ./plex.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config.allowUnfree = true;
  };

  nix = {
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      trusted-users = ["root" "actuary" "@wheel"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

  networking.hostName = "coral";
  networking.networkmanager.enable = lib.mkDefault true;
  networking.enableIPv6 = true;
  networking.firewall.enable = false;

  time.timeZone = lib.mkDefault "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.actuary = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker" "networkmanager"];
    initialPassword = "correcthorsebatterystaple";
    openssh.authorizedKeys.keys = [
      # Add your SSH public key here
    ];
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    btop
    openssl
    unzip
    docker-compose
    glances
    nfs-utils
  ];

  services.openssh.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "23.05";
}

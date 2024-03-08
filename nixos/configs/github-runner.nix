{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    github-runner
  ];

  # Configure GitHub runners using the new structure
  services.github-runners = {
    # Define each runner as an attribute of `services.github-runners`
    laptop = {
      enable = true;
      url = "https://github.com/AlexanderTroyScott/NixOS";
      tokenFile = "/etc/nixos/runner.token";
      replace = true;
      serviceOverrides = {
        ProtectHome = false;
      };
      extraLabels = ["Xiaomi Book 16"];
      name = "laptop";
      user = "alex";
      workDir = "/tmp/Github";
      nodeRuntimes = ["node20"];
      extraPackages = with pkgs; [
        nixos-rebuild
        networkmanager
      ];
    };
  };
}

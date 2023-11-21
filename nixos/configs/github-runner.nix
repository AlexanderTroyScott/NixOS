{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
  git
  github-runner
  ];

  services.github-runner.enable = true;
  services.github-runner.url = "https://github.com/AlexanderTroyScott/NixOS";
  #Token needs to have read/write Administration priviledges to create runners.
  services.github-runner.tokenFile = "/etc/nixos/runner.token";
  services.github-runner.replace = true;
  services.github-runner.serviceOverrides = {
    ProtectHome = false;
  };

  services.github-runners.laptop.extraLabels = ["Xiaomi Book 16"];
  services.github-runner.name = "laptop";
  services.github-runner.user = "alex";
  services.github-runner.workDir = "/tmp/Github";
  services.github-runner.nodeRuntimes = ["node20"];
  services.github-runner.extraPackages = with pkgs; [
    nixos-rebuild
    networkmanager
  ];
}
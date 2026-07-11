  { lib, config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker
  ];

 #   users.groups.docker = {
 #   name = "docker";
 # };
 # users.extraGroups.docker.members = ["actuary"];
  virtualisation.docker.enable = true;
  #virtualisation.docker.rootless = {
  #  enable = true;
  #  setSocketVariable = true;
  #};
  virtualisation.docker.liveRestore = false;

  networking.firewall.allowedTCPPorts = [ 2377 7946 ];
  networking.firewall.allowedUDPPorts = [ 7946 4789 ];
  #virtualisation.docker.storageDriver = "btrfs";

  # (Optional) Enable Docker registry.
  services.dockerRegistry.enable = true;
  #virtualisation.docker.extraOptions = "--ipv6 --fixed-cidr-v6 fd00::/80";
  
  virtualisation.docker.daemon.settings = {
    #data-root = "/home/das/docker/";
    #userland-proxy = false;
    #experimental = true;
    ipv6 = true;
    #fixed-cidr-v6 = "fd00::/80";
    #metrics-addr = "0.0.0.0:9323";
    #log-driver = "json-file";
    #log-opts.max-size = "10m";
    #log-opts.max-file = "10";
  };
}


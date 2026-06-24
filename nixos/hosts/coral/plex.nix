{pkgs, ...}: {
  fileSystems."/mnt/user/services/plex" = {
    device = "unraid.lan:/mnt/user/services/plex";
    fsType = "nfs";
    options = ["rw" "nofail" "_netdev"];
  };

  services.plex = {
    enable = true;
    openFirewall = true;
    user = "actuary";
    dataDir = "/mnt/user/services/plex";
  };
}

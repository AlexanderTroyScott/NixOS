let
  nfsOptions = ["nofail" "soft" "timeo=10" "retrans=2" "x-systemd.automount" "noauto" "_netdev"];
in {
  fileSystems."/mnt/user/docker/volumes" = {
    device = "unraid.lan:/mnt/user/docker/volumes";
    fsType = "nfs4";
    options = ["nofail" "soft" "timeo=10" "retrans=2" "_netdev"];
  };

  fileSystems."/mnt/user/library" = {
    device = "unraid.lan:/mnt/user/library";
    fsType = "nfs";
    options = nfsOptions;
  };

  fileSystems."/mnt/user/vault" = {
    device = "unraid.lan:/mnt/user/vault";
    fsType = "nfs";
    options = nfsOptions ++ ["sync"];
  };

  fileSystems."/mnt/user/scan" = {
    device = "unraid.lan:/mnt/user/scan";
    fsType = "nfs";
    options = nfsOptions ++ ["sync"];
  };
}

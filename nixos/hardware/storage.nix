let
  nfsOptions = [
    "nofail"
    "rw"
    "soft"
    "timeo=14"
    "_netdev"
    "x-systemd.automount"
    "x-systemd.idle-timeout=600"
    "x-systemd.mount-timeout=10"
  ];
in
{
  fileSystems."/unraid/docker/volumes" = {
    device = "192.168.2.2:/mnt/ssd/docker/volumes";
    fsType = "nfs4";
    neededForBoot = false;
    options = nfsOptions;
  };
  fileSystems."/unraid/photo" = {
    device = "192.168.2.2:/mnt/ssd/photo";
    fsType = "nfs4";
    neededForBoot = false;
    options = nfsOptions;
  };
  fileSystems."/unraid/library" = {
    device = "192.168.2.2:/mnt/user/library";
    fsType = "nfs4";
    neededForBoot = false;
    options = nfsOptions;
  };
  fileSystems."/unraid/vault" = {
    device = "192.168.2.2:/mnt/ssd/vault";
    fsType = "nfs4";
    neededForBoot = false;
    options = nfsOptions;
  };
  fileSystems."/unraid/reolink" = {
    device = "192.168.2.2:/mnt/user/reolink";
    fsType = "nfs4";
    neededForBoot = false;
    options = nfsOptions ++ [ "exec" ];
    # "uid=1000"   # Replace with your local user’s UID
    # "gid=100"    # Replace with your local user’s GID
  };
  fileSystems."/unraid/scan" = {
    device = "unraid.lan:/mnt/ssd/scan";
    fsType = "nfs4";
    neededForBoot = false;
    options = nfsOptions;
  };
  fileSystems."/zephyr/test" = {
    device = "192.168.2.184:/mnt/user/testz";
    fsType = "nfs4";
    neededForBoot = false;
    options = nfsOptions;
  };
}

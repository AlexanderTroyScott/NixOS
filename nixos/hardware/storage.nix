{
 #services.autofs.enable = true;
  fileSystems."/unraid/docker/volumes" = {
	device = "192.168.2.2:/mnt/user/docker/volumes";
	fsType = "nfs4";
	neededForBoot = false;
  #automount.enable = true;
  options = [
  "nofail"
	"rw"
	"hard"
	"intr"
	];
  };
  fileSystems."/unraid/library" = {
	device = "192.168.2.2:/mnt/user/library";
	fsType = "nfs4";
	neededForBoot = false;
  #automount.enable = true;
  options = [
  "nofail"
	"rw"
	"hard"
	"intr"
	];
  };
 fileSystems."/unraid/vault" = {
	device = "192.168.2.2:/mnt/user/vault";
	fsType = "nfs4";
	neededForBoot = false;
  #automount.enable = true;
  options = [
  "nofail"
	"rw"
	"hard"
	"intr"
	];
  };

  fileSystems."/unraid/games" = {
    device = "192.168.2.2:/mnt/user/games";
    fsType = "nfs4";
    neededForBoot = false;
    options = [
      "nofail"
      "rw"
      "hard"
      "intr"
      "exec"
     # "uid=1000"   # Replace with your local user’s UID
     # "gid=100"     # Replace with your local user's GID
    ];
  };


  fileSystems."/unraid/scan" = {
  device = "unraid.lan:/mnt/user/scan";
  fsType = "nfs4";
  neededForBoot = false;
  options = [
  "nofail"
	"rw"
	"hard"
	];
  };

}

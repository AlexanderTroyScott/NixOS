{
fileSystems."/unraid/games/" = {
    device = "192.168.2.2:/mnt/user/games";
    fsType = "nfs4";
    neededForBoot = false;
    options = ["rw", "hard", "nofail", "initr";]
}
}
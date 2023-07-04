{ config, pkgs, ... }:

{
  #TouchPad
  services.xserver.libinput.enable = true;
  #Power Settings
  services.power-profiles-daemon.enable = false;
  services.tlp = {
  enable = true;
  settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  };
};

}

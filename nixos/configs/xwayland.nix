{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
  libinput
  xorg.xinput
  #xterm
  ];

  programs.hyprland = {
    xwayland.enable = true;  
  };
    #TouchPad
    services.xserver.libinput = {
    enable = true;  #Expected to be enabled by default
    touchpad = {
      dev = "/dev/input/event6";
      sendEventsMode = "enabled";
      scrollMethod = "twofinger"; #one of "twofinger", "edge", "button", "none"
      naturalScrolling = true; # Enables natural/reverse scrolling
      tapping = true; # Enables tap-to-click
      tappingDragLock = false; # Enables tap-and-drag
    };
  };
 #services.xserver.displayManager.sddm.enable = true; #This line enables sddm
 #services.xserver.enable = true; 
#services.xserver.libinput.touchpad.tappingDragLock = false;

}
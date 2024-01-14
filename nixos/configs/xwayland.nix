{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
  libinput
  ];

  programs.hyprland = {
    xwayland.enable = true;  
  };
}
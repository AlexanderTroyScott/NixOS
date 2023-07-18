{ config, lib, pkgs, unstable, hyprland, user, ... }:

{ 
  home = {
    stateVersion = "23.05";
  };
  home.packages = with pkgs; [libva];
  
  programs = {
    home-manager.enable = true;
  };

}

{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  #hyprland,
  #home-manager,
  ...
}: {
 home.packages = with pkgs; [
    
    hyprcursor
    catppuccin-cursors.mochaMauve
 ];
}
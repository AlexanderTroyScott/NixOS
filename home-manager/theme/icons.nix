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
    
    papirus-icon-theme
 ];
}
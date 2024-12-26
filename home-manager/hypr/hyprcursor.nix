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
 ];
 home.pointerCursor.hyprcursor.enable = true;
 home.pointerCursor.hyprcursor.size = 32;
 
}
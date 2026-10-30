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
  home.pointerCursor = {
    enable = true;
    hyprcursor.enable = true;
    hyprcursor.size = 20;
  };
}

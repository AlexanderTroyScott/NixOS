{ config, lib, pkgs, unstable, user, ... }:

{ 
  home = {
    stateVersion = "23.05";
  };

  programs = {
    home-manager.enable = true;
  };
}
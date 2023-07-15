{ config, lib, pkgs, unstable, user, ... }:

{ 
  home = {
    username = "alex";
    #homeDirectory = "/home/alex";
    stateVersion = "23.05";
  };

  programs = {
    home-manager.enable = true;
  };
}

{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
    source=/home/alex/Documents/NixOS/hosts/laptop/.config/hypr/hyprland.conf
  '';
  };
}
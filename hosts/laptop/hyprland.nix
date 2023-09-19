{ config, lib, pkgs, host, system, ... }:
{
 wayland.windowManager.hyprland.extraConfig = ''
   source=/home/alex/Documents/NixOS/hosts/laptop/.config/hypr/hyprland.conf
  '';
}

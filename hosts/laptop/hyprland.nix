{ config, lib, pkgs, host, system, ... }:
{
let
hyprlandConf = ''
    source = /home/alex/Documents/NixOS/hosts/laptop/.config/hypr/hyprland.conf
     '';
in
{
  xdg.configFile."hypr/hyprland.conf".text = hyprlandConf;
 };
}
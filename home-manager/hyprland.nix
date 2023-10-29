
{ config, pkgs, inputs, hyprland, ... }:
{
  #imports = [ inputs.hyprland.nixosModules.default ];
  #home.packages = with pkgs; [
 #     hyprland
  #];
  #home.packages = with pkgs; [ hyprland ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = ''
    source=/home/alex/Documents/NixOS/hosts/laptop/.config/hypr/hyprland.conf
  '';
  };
}
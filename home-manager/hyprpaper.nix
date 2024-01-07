{ pkgs, ... }:

{
  # Other configurations

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = /home/alex/Pictures/Wallpaper/black_cat.jpeg
    wallpaper = eDP-1,/home/alex/Pictures/Wallpaper/black_cat.jpeg
    wallpaper = desc:Dell Inc. DELL P2414H 524N34963F2L,/home/alex/Pictures/Wallpaper/black_cat.jpeg
    wallpaper = desc:Dell Inc. DELL P2414H 524N34963P1L,/home/alex/Pictures/Wallpaper/black_cat.jpeg
    splash = false
  '';
}
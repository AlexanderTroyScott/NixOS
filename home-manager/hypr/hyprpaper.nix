{pkgs, ...}: {
  home.packages = with pkgs; [
    hyprpaper
  ];
  # https://github.com/hyprwm/hyprpaper
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = /home/alex/Pictures/Wallpaper/black_cat.jpeg
    wallpaper = ,/home/alex/Pictures/Wallpaper/black_cat.jpeg
    splash = false
    ipc = off
  '';
}

{ pkgs, ... }:

{
    home.packages = with pkgs; [
        hyprlock
    ];
  # https://github.com/hyprwm/hyprpaper
  xdg.configFile."hypr/hyprlock.conf".text = ''

  general {
    grace = 30
  }

  background {
    monitor =
    path = /home/alex/Pictures/Wallpaper/black_cat.png   # only png supported for now
    color = rgba(25, 20, 20, 1.0)

    # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
    blur_passes = 0 # 0 disables blurring
    blur_size = 7
    noise = 0.0117
    contrast = 0.8916
    brightness = 0.8172
    vibrancy = 0.1696
    vibrancy_darkness = 0.0
}

input-field {
    monitor =
    size = 200, 50
    outline_thickness = 3
    dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
    dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
    dots_center = false
    outer_color = rgb(151515)
    inner_color = rgb(200, 200, 200)
    font_color = rgb(10, 10, 10)
    fade_on_empty = true
    placeholder_text = <i>Input Password...</i> # Text rendered in the input box when it's empty.
    hide_input = false

    position = 0, -20
    halign = center
    valign = center
}
# TIME
label {
    monitor =
    text = cmd[update:1000] echo "$(date +"%-I:%M%p")"
    color = $foreground
    #color = rgba(255, 255, 255, 0.6)
    font_size = 120
    font_family = JetBrains Mono Nerd Font Mono ExtraBold
    position = 0, -300
    halign = center
    valign = top
}

label {
    monitor =
    text = $USER
    color = rgba(200, 200, 200, 1.0)
    font_size = 25
    font_family = Noto Sans

    position = 0, 80
    halign = center
    valign = center
}
  '';
}
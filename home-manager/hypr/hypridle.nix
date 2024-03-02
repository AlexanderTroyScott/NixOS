{ pkgs, ... }:

{
    home.packages = with pkgs; [
        hypridle
    ];

  xdg.configFile."hypr/hypridle.conf".text = ''
    listener {
      timeout = 300                           # 5min
      on-timeout = hyprlock                   # lock screen when timeout has passed
      on-resume = notify-send "Welcome back!" # notification activity is detected after timeout has fired.
    }

    listener {
      timeout = 380                           # 5.5min
      on-timeout = hyprctl dispatch dpms off  # screen off when timeout has passed
      on-resume = hyprctl dispatch dpms on    # screen on when activity is detected after timeout has fired.
    }

    listener {
        timeout = 1800                          # 30min
        on-timeout = systemctl suspend          # suspend pc
    }
  '';
}
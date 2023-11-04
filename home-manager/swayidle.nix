# NixOS configuration for swayidle
{ config, pkgs, ... }:

{
 home.packages = with pkgs; [ 
        pkgs.swayidle
        pkgs.swaylock-effects
    ];
    
  services.swayidle = {
    enable = true;
    events = [
      { event = "lock"; command = "${pkgs.swaylock-effects}/bin/swaylock -f --screenshot --effect-blur 5x7 --grace 5 --clock --indicator";}
      { event = "before-sleep"; command = "${pkgs.swaylock-effects}/bin/swaylock -f --screenshot --effect-blur 5x7 --grace 5 --clock --indicator";}
      #{ event = "after-resume"; command = "${pkgs.sway}/bin/swaymsg \"output * toggle\"";}
    ];
    timeouts = [
      { timeout = 60; command = "${pkgs.swaylock-effects}/bin/swaylock -f --screenshot --effect-blur 5x7 --grace 5 --clock --indicator";}
      #{ timeout = 1200; command = "${pkgs.sway}/bin/swaymsg \"output * toggle\"";}
    ];
  };

}

#swaylock -f --screenshot --effect-blur 5x7 --grace 5 --clock --indicator
# FILEPATH: /home/alex/.config/nixpkgs/home.nix

{ config, pkgs, ... }:

#let
    # Define the default options for swayidle
#    swayidleOptions = {
#        timeout = 300;
#        fade_in = 0;
#        fade_out = 0;
#        idle_command = "swaymsg 'output * dpms off'";
#        resume_command = "swaymsg 'output * dpms on'";
#    };
#in
{
    home.packages = [
        # Install swayidle
        pkgs.swayidle
        pkgs.swaylock
    ];
    security.pam.services.swaylock = {};
    services.swayidle = {
    enable = true;
    events = [
        { event = "lock"; command = "${pkgs.swaylock}/bin/swaylock";}
        { event = "before-sleep"; command = "${pkgs.swaylock}/bin/swaylock";}
        #{ event = "after-resume"; command = "${pkgs.sway}/bin/swaymsg \"output * toggle\"";}
    ];
    timeouts = [
        { timeout = 20; command = "${pkgs.swaylock}/bin/swaylock";}
        #{ timeout = 1200; command = "${pkgs.sway}/bin/swaymsg \"output * toggle\"";}
    ];
  };
}

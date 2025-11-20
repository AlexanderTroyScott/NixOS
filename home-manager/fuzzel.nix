{ config, pkgs, ... }:
{
  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main = {
        terminal          = "${pkgs.kitty}/bin/kitty";
        layer             = "overlay";
        dpi-aware         = "auto";
        icons-enabled     = "yes";
        image-size-ratio  = "1.0";    #Between 0.0 and 1.0
        fuzzy             = "yes";    #fuzzy search matching
        width             = "90";     #default 30
        lines             = "10";     #default 15
        line-height       = "20";     #default is to use font height
    };
  };
}
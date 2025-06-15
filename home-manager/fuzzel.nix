{ config, pkgs, ... }:
{
  programs.fuzzel.enable = true;
  #programs.fuzzel.package
  programs.fuzzel.settings = {
    
    main = {
        terminal = "${pkgs.kitty}/bin/kitty";
        layer = "overlay";
        # font="monospace"; #Dina:weight=bold:slant=italic
        #Arial:size=12

        dpi-aware="auto";
        icons-enabled="yes";
        #icons-theme="Papirus-Dark";
        image-size-ratio="1.0"; #Between 0.0 and 1.0
        fuzzy ="yes"; #fuzzy search matching
        #Window
        width="90"; #default 30
        lines="10"; #default 15
        line-height="20"; #default is to use font height
    };
   # colors = {
   #     background="282a36dd";
   #     text="f8f8f2ff";
   #     match="8be9fdff";
   #     selection-match="8be9fdff";
   #     selection="44475add";
   #     selection-text="f8f8f2ff";
   #     border="bd93f9ff";
   # };

  };
}
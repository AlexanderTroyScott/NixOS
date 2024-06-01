{
fonts= {
  packages = with pkgs; [                # Fonts
    carlito                                 # NixOS
    vegur                                   # NixOS
    source-code-pro
    jetbrains-mono
    font-awesome                            # Icons
    corefonts                               # MS
    # nerdfonts
      (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
  ];};
 # Font configuration
  fonts.fontconfig.defaultFonts = {
    monospace = [ "FiraCode" ];
    sansSerif = [ "FiraCode" ];
    serif = [ "FiraCode" ];
    #monospace = [ "FiraCode" ];
    emoji =[ "FiraCode" ];
    #monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
    #emoji = ["Noto Color Emoji"];
  };

}
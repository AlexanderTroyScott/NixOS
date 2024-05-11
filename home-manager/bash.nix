{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      # Add your aliases here if needed
    };
#    initExtra = ''
#      if [ "$VM_GPU" = "true" ] && [ -z "$DISPLAY" ]; then
#          dbus-run-session Hyprland
#      fi
#    '';
#    initExtra = ''
#      if [ "$VM_GPU" = "true" ]; then
#          dbus-run-session Hyprland
#      fi
#    '';
  };
}

{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      # Add your aliases here if needed
    };
    initExtra = ''
      if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
          dbus-run-session Hyprland
      fi
    '';
  };
}

{ ... }:
{
  # Zenbook-specific monitor configuration
  # Display descriptions are hardware-specific identifiers from `hyprctl monitors`
  wayland.windowManager.hyprland.extraConfig = ''
    # See https://wiki.hyprland.org/Configuring/Monitors/

    # All monitor configuration handled by Kanshi profiles in home.nix
    # See services.kanshi.settings in home.nix for profiles

    # ASUS keyboard backlight (asus::kbd_backlight device)
    bind =, XF86KbdBrightnessDown, exec, brightnessctl -d asus::kbd_backlight set 1-
    bind =, XF86KbdBrightnessUp, exec, brightnessctl -d asus::kbd_backlight set +1
  '';
}

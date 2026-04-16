{ ... }:
{
  # Zenbook-specific monitor configuration
  # Display descriptions are hardware-specific identifiers from `hyprctl monitors`
  wayland.windowManager.hyprland.extraConfig = ''
    # See https://wiki.hyprland.org/Configuring/Monitors/

    # Docked - work (Dell monitors)
    monitor=desc:Dell Inc. DELL P2414H 524N34963F2L,1920x1080,0x0,1,transform,1
    monitor=desc:Dell Inc. DELL P2414H 524N34963P1L,1920x1080,1080x0,1

    # Docked - home (LG 4K monitors)
    monitor=desc:LG Electronics LG HDR 4K 0x0001D608,3840x2160@60,auto,1
    monitor=desc:LG Electronics LG HDR 4k 0x0001D6E3,3840x2160@60,auto,1

    # Zenbook Duo portable displays
    #TODO: make keybind to toggle orientation/side
    #TODO: replace DP port names with descriptions
    monitor = DP-4, 1920x1200@60, auto-left, 1.5, transform, 3
    monitor = DP-3, 1920x1200@60, 0x0, 1.5, transform, 3

    # Built-in display (Samsung Display Corp. 0x419D)
    monitor=desc:Samsung Display Corp. 0x419D,2880x1800,auto,2

    # Lid switch: enable/disable built-in display on lid open/close
    bind = , switch:off:Lid Switch, exec, hyprctl keyword monitor "desc:Samsung Display Corp. 0x419D, 2880x1800@60, 0x0, auto"
    bind = , switch:on:Lid Switch, exec, hyprctl keyword monitor "desc:Samsung Display Corp. 0x419D, disable"

    # ASUS keyboard backlight (asus::kbd_backlight device)
    bind =, XF86KbdBrightnessDown, exec, brightnessctl -d asus::kbd_backlight set 1-
    bind =, XF86KbdBrightnessUp, exec, brightnessctl -d asus::kbd_backlight set +1
  '';
}

{...}: {
  # Zenbook-specific monitor configuration
  # Display descriptions are hardware-specific identifiers from `hyprctl monitors`
  wayland.windowManager.hyprland.extraLuaFiles."monitors" = {
    autoLoad = true;
    content = ''
      -- Monitor configuration
      -- Hyprland applies rules to connected monitors; unmatched monitors get defaults
      -- LG 4K monitors (docked-home)
      hl.config({ monitor = { "LG Electronics LG HDR 4K 0x0001D6E3", "3840x2160@60, 0x0, 1.5" } })
      hl.config({ monitor = { "LG Electronics LG HDR 4K 0x0001D608", "3840x2160@60, 3840x0, 1.5" } })
      -- Laptop display (used when undocked)
      hl.config({ monitor = { "eDP-1", "2880x1800@120, 0x0, 2" } })

      -- ASUS keyboard backlight (asus::kbd_backlight device)
      hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("brightnessctl -d asus::kbd_backlight set 1-"))
      hl.bind("XF86KbdBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -d asus::kbd_backlight set +1"))
    '';
  };
}

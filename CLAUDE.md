# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Commands

```bash
# Rebuild and switch to the new configuration (run as root or with sudo)
sudo nixos-rebuild switch --flake .#zenbook

# Rebuild without switching (test build)
sudo nixos-rebuild build --flake .#zenbook

# Update flake inputs
nix flake update

# Format all Nix files
nix fmt

# Check flake for errors
nix flake check
```

## Architecture

This is a **NixOS flake-based configuration** for a single host (`zenbook` — ASUS Zenbook laptop).

**Entry point:** `flake.nix` — defines inputs (nixpkgs-unstable, home-manager, stylix, zen-browser) and the single `nixosConfigurations.zenbook` output.

**Two-layer structure:**
- `nixos/` — system-level configuration (runs as root, affects the whole system)
- `home-manager/` — user-level configuration for `alex` (dotfiles, user packages, desktop apps)

### nixos/ layout

| File | Role |
|------|------|
| `configuration.nix` | Core: users, networking, Docker, SSH, base packages |
| `desktop.nix` | Desktop environment: Hyprland WM, Stylix theming, display manager auto-login |
| `building.nix` | Distributed build config (remote builder at `192.168.209.156`) |
| `hardware/zenbook/hardware-configuration.nix` | Auto-generated hardware config — don't edit manually |
| `hardware/zenbook/sound.nix` | PipeWire / ALSA / JACK audio |
| `hardware/storage.nix` | NFS mounts to Unraid server |
| `hardware/printer.nix` | Canon printer via CUPS |
| `configs/fonts.nix` | System fonts (Fira Code, DejaVu, etc.) |
| `configs/wireguard.nix` | WireGuard firewall rules |

### home-manager/ layout

| File | Role |
|------|------|
| `home.nix` | User packages, session vars, imports all other home-manager modules |
| `desktop.nix` | Desktop apps + Kanshi display profiles for docked/undocked setups |
| `hypr/hyprland.nix` | Hyprland WM keybindings, monitor config, window rules, animations |
| `hypr/hyprpanel.nix` | Hyprpanel bar (workspaces, clock, tray, volume) |
| `hypr/hyprlock.nix` | Lock screen styling |
| `hypr/hypridle.nix` | Idle timeouts (5min lock → 5.5min DPMS off → 30min suspend) |
| `hypr/hyprpaper.nix` | Wallpaper management |
| `vscode.nix` | VS Code extensions and settings |
| `kitty.nix` | Kitty terminal config |
| `fuzzel.nix` | App launcher config |

### overlays/default.nix

Defines three overlays: `additions` (custom pkgs), `modifications` (patched pkgs, e.g. pcloud), and `unstable-packages` (access nixpkgs-unstable packages as `pkgs.unstable.*`).

## Key Patterns

- **Theming** is handled by Stylix (configured in `nixos/desktop.nix`) using the Dracula base16 scheme. It automatically themes many apps.
- **Unstable packages** are accessed via `pkgs.unstable.packageName` anywhere in the config, thanks to the overlay.
- To add a new NixOS module, import it in `nixos/configuration.nix` or `nixos/desktop.nix`. To add a home-manager module, import it in `home-manager/home.nix`.
- Monitor/display profiles are managed by **Kanshi** (in `home-manager/desktop.nix`) for automatic switching between docked and undocked layouts.

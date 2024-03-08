
{ config, pkgs, inputs, ... }:
{
  #imports = [ inputs.hyprland.nixosModules.default ];
  #home.packages = with pkgs; [
 #     hyprland
  #];
  #home.packages = with pkgs; [ hyprland ];

  wayland.windowManager.hyprland = {
    enable = true;
    
    extraConfig = ''
      # See https://wiki.hyprland.org/Configuring/Monitors/
      #monitor=desc:Samsung Display Corp. 0x4173,3840x2400,0x0,auto

      #work monitors
      #left
      #monitor=desc:Dell Inc. DELL P2414H 524N34963F2L,1920x1080,0x0,1,transform,1
      #right
      #monitor=desc:Dell Inc. DELL P2414H 524N34963P1L,1920x1080,1080x0,1
      #---------------------------------
      #home monitors
        
      #left
      monitor=desc:LG Electronics LG HDR 4K 0x0001D608,3840x2160@60,auto,1
      #middle
      monitor=desc:LG Electronics LG HDR 4k 0x0001D6E3,3840x2160@60,auto,1


      monitor=desc:Samsung Display Corp. 0x4173,3840x2400,auto,2

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Execute your favorite apps at launch
      # exec-once = waybar & hyprpaper & firefox

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # Some default env vars.
      #env = XCURSOR_SIZE,48

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us
          kb_variant =
          kb_model = pc104
          kb_options =
          kb_rules =
          follow_mouse = 1
          scroll_method = 2fg
          scroll_button = 9 #escape
          touchpad {
              natural_scroll = yes
              tap-to-click = no
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
     
     
      }
     #device:01e0-mouse {
     #       input {
     #       touchpad {
     #       natural_scroll = no
     #       tap-to-click = yes
     #       }
     #       }
     #     }
      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 5
          gaps_out = 7
          border_size = 2
          col.active_border = rgba(6272a4ff) rgba(bd93f9ff) 45deg
          col.inactive_border = rgba(44475aff)
          resize_on_border = true
          layout = dwindle
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 10
          inactive_opacity = .64
          #blur = yes
          #blur_size = 3
          #blur_passes = 1
          #blur_new_optimizations = on

          #drop_shadow = yes
          #shadow_range = 4
          #shadow_render_power = 3
          #col.shadow = rgba(1a1a1aee)

          #Battery optimisations
          blur {
            enabled = false
          }
          drop_shadow = false
      }

      animations {
          enabled = yes

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
      }

      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = true
      }

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      #device:epic-mouse-v1 {
      #    sensitivity = -0.5
      #}

      misc {
        force_default_wallpaper = 0
        disable_hyprland_logo = 1
        disable_splash_rendering = 1
        disable_autoreload = true #This is handled with nixos rebuild
        #Battery optimisations
        vfr = true
     }
      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      windowrulev2 = float,title:(Picture in picture),class:()
      windowrulev2 = opacity 0.05 override 1.0 override,title:(Picture in picture),class:()
      windowrulev2 = pin,title:(Picture in picture)
      windowrulev2 = move 1046 708,class:(), title:(Picture in picture)

      #windowrulev2 = pin,   class:^(firefox)$, title:^(Picture-in-Picture)$
      #windowrulev2 = float, class:^(firefox)$, title:^(Picture-in-Picture)$
      #windowrulev2 = pin,   class:^(firefox)$, title:^(Picture-in-Picture)$
      #windowrulev2 = size 800 450, class:^(firefox)$, title:^(Picture-in-Picture)$
      windowrulev2 = size 848 468, title:(Picture in picture), class:()
      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER

      

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, Q, exec, kitty
      bind = $mainMod, C, killactive, 
      bind = $mainMod, M, exit,
      bind = $mainMod, F, fullscreen, 
      bind = $mainMod, E, exec, dolphin
      bind = $mainMod, L, exec, hyprlock
      bind = $mainMod, V, togglefloating, 
      bind = $mainMod, R, exec, fuzzel
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle
      bind = $mainMod, X, exec, grim -g "$(slurp -d)" - | wl-copy -t image/png
      bind = $mainMod, grave, exec, fuzzel
      bind = , switch:off:Lid Switch,exec,hyprctl keyword monitor "desc:Samsung Display Corp. 0x4173, 3840x2400@60, 0x0, auto"
      bind = , switch:on:Lid Switch,exec,hyprctl keyword monitor "desc:Samsung Display Corp. 0x4173, disable"
      #grave is ~

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1
      #F1-9
      bind =, XF86AudioMute, exec,pamixer -t
      bind =, XF86AudioLowerVolume, exec,pamixer -d 9
      bind =, XF86AudioRaiseVolume, exec,pamixer -i 9
      bind =, XF86MonBrightnessDOWN, exec,light  -U .29
      bind =, XF86MonBrightnessUP, exec, light -A 3


      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      #windowrulev2 = float,class:(kitty)
      #windowrulev2 = fullscreen,class:(vivaldi-stable)
      windowrulev2 = workspace:(coding),title:(Visual Studio Code)

      workspace = 2, name:browser, monitor:eDP-1, default:true
      workspace = 1, name:coding, rounding:false, decorate:false, gapsin:0, gapsout:0, border:false, decorate:false, monitor:eDP-1

      exec-once = waybar & hyprpaper & nm-applet & blueman-applet
  '';
  };
}

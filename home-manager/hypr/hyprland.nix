
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
    #env = QT_QPA_PLATFORM,wayland
    #env = QT_QPA_PLATFORMTHEME,qt5ct
      # See https://wiki.hyprland.org/Configuring/Monitors/
      #monitor=desc:Samsung Display Corp. 0x4173,3840x2400,0x0,auto

      #work monitors
      #left
      monitor=desc:Dell Inc. DELL P2414H 524N34963F2L,1920x1080,0x0,1,transform,1
      #right
      monitor=desc:Dell Inc. DELL P2414H 524N34963P1L,1920x1080,1080x0,1
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
      #env = XCURSOR_SIZE,32

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us
          kb_variant =
          kb_model = pc104
          kb_options =
          kb_rules =
          follow_mouse = 1
          scroll_method = 2fg #2fg/edge/on_button_down/no_scroll
          scroll_button = 9 #escape
          touchpad {
              natural_scroll = yes
              tap-to-click = no
              scroll_factor = 0.5
          }
          sensitivity = 0.4 # -1.0 - 1.0, 0 means no modification.
          

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

          
          blur {
            enabled = false             #Battery optimisations
            popups_ignorealpha = 1
          }
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

      #master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      #    new_is_master = true
      #}

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
      $PictureInPicture = Picture-In-Picture
      windowrulev2 = float,title:($PictureInPicture)
      windowrulev2 = float,title:(Picture-in-Picture)
      windowrulev2 = opacity 0.05 override 1.0 override,title:(Picture-in-Picture)
      windowrulev2 = pin,title:(Picture-in-Picture)
      windowrulev2 = move 1046 708, title:(Picture-in-Picture)

      #windowrulev2 = pin,   class:^(firefox)$, title:^(Picture-in-Picture)$
      #windowrulev2 = float, class:^(firefox)$, title:^(Picture-in-Picture)$
      #windowrulev2 = pin,   class:^(firefox)$, title:^(Picture-in-Picture)$
      #windowrulev2 = size 800 450, class:^(firefox)$, title:^(Picture-in-Picture)$
      windowrulev2 = size 848 468, title:(Picture-in-Picture)
      windowrulev2 = float,class:(floating)  
      # See https://wiki.hyprland.org/Configuring/Keywords/ for more$ nix-env --delete-generations 14d

      $mainMod = SUPER

      

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, Q, exec, kitty
      bind = $mainMod, C, killactive, 
      bind = $mainMod, M, exit,
      bind = $mainMod, F, fullscreen, 
      bind = $mainMod, E, exec, dolphin
      bind = $mainMod, L, exec, hyprlock 
      bind = $mainMod, V, exec,  kitty --class floating -e bash  -c 'clipse $PPID' 
      bind = $mainMod, R, exec, fuzzel
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle
      bind = $mainMod, X, exec, grim -g "$(slurp -d)" - | wl-copy -t image/png
      bind = $mainMod, grave, exec, fuzzel
      bind = , switch:off:Lid Switch,exec,hyprctl keyword monitor "desc:Samsung Display Corp. 0x4173, 3840x2400@60, 0x0, auto"
      bind = , switch:on:Lid Switch,exec,hyprctl keyword monitor "desc:Samsung Display Corp. 0x4173, disable"
      #suspend and lock
      bind = $mainMod, DELETE, exec, systemctl suspend && hyprlock --immediate
      #grave is ~
      bind = $mainMod, W, exec, pkill waybar || waybar &

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

#windowrulev2 = fullscreen,class:^steam_app\d+$
#windowrulev2 = monitor 1,class:^steam_app_\d+$
#windowrulev2 = workspace 10,class:^steam_app_\d+$
#workspace = 10, border:false, rounding:false


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

      workspace = 3, default:true, persistent:true
      workspace = 2, rounding:false, decorate:false, gapsin:0, gapsout:0, border:false, decorate:false, persistent:true
      workspace = 8, rounding:false, decorate:false, gapsin:0, gapsout:0, border:false, decorate:false, persistent:true

      #windowrulev2 = workspace:(coding),class:^steam_app_\d+$
      windowrulev2 = workspace 8 silent,initialClass:(vesktop)
      windowrulev2 = workspace 2 silent,initialClass:(code) 
      #windowrulev2 = workspace 2 silent, class:^(firefox)$, title:^(firefox)$
      
      misc{
      disable_autoreload = true
      }

      exec-once = waybar & hyprpaper & nm-applet & blueman-applet & clipse -listen  & hyprctl dispatch exec code 
      exec-once = hyprctl dispatch exec vesktop & hyprctl dispatch exec zen

  '';
  };
}



{ config, pkgs, inputs, ... }:
{
  #to-do: SEARCH TODO
  #

  #imports = [ inputs.hyprland.nixosModules.default ];
  #home.packages = with pkgs; [
 #     hyprland
  #];
  #home.packages = with pkgs; [ hyprland ];

  wayland.windowManager.hyprland = {
    enable = true;
    
    extraConfig = ''
    #TODO: Cleanup env and determine if those are just overwrting one another
    #env = XCURSOR_SIZE,32
    env = GDK_BACKEND,wayland,x11,*
    env = QT_QPA_PLATFORM,wayland;xcb
    #env = QT_QPA_PLATFORM,wayland
    #env = QT_QPA_PLATFORMTHEME,qt5ct
    env = GDK_SCALE,2
    env = XCURSOR_SIZE,20

    #TODO: Move monitors in a stand-alone file
      # See https://wiki.hyprland.org/Configuring/Monitors/
      #docked
      #work
        #left
        monitor=desc:Dell Inc. DELL P2414H 524N34963F2L,1920x1080,0x0,1,transform,1
        #right
        monitor=desc:Dell Inc. DELL P2414H 524N34963P1L,1920x1080,1080x0,1
      #home
        #left
        monitor=desc:LG Electronics LG HDR 4K 0x0001D608,3840x2160@60,auto,1
        #middle
        monitor=desc:LG Electronics LG HDR 4k 0x0001D6E3,3840x2160@60,auto,1
      #zenbook duo
      #TODO: make keybind for the portable monitors to set orientation/side
      #TODO: replace monitors with descriptions
        monitor = DP-4, 1920x1200@60, auto-left, 1.5, transform, 3
        monitor = DP-3, 1920x1200@60, 0x0, 1.5, transform, 3
      #laptops
        #XIAOMI MI BOOK
        monitor=desc:Samsung Display Corp. 0x4173,3840x2400,auto,2
        #zenbook
        monitor=desc:Samsung Display Corp. 0x419D,2880x1800,auto,2

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf


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
              tap-to-click = yes
              scroll_factor = 0.5
          }
          sensitivity = 0.4 # -1.0 - 1.0, 0 means no modification.
      }

      xwayland {
        enabled = true
        force_zero_scaling = true
      }
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

      gesture = 3, horizontal, workspace

      misc {
        force_default_wallpaper = 0
        disable_hyprland_logo = 1
        disable_splash_rendering = 1
        disable_autoreload = true #This is handled with nixos rebuild
        #Battery optimisations
        vfr = true
     }
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      #TODO: Put windowrules in separate file
      $PictureInPicture = Picture-In-Picture
      #windowrulev2 = float,title:($PictureInPicture)
      #windowrulev2 = float,title:(Picture-in-Picture)
      #windowrulev2 = opacity 1.00 override 1.0 override,title:(Picture-in-Picture)
      #windowrulev2 = opacity 0.05 override 1.0 override,title:(Picture-in-Picture)
      #windowrulev2 = float,class:(floating)  
      #windowrulev2 = pin,title:(Picture-in-Picture)
      #TODO: Make picture-in-picture based upon the flake being used (i.e. zenbook uses different pixels)
      #mibook
      #windowrulev2 = move 1046 708, title:(Picture-in-Picture)
      #windowrulev2 = size 848 468, title:(Picture-in-Picture)
      #zenbook. 
      #To get coorinates make a PIP and customize to preferences
      #run hyprctl clients to see the size/location
      #update config, rebuild and hyprctl reload
      #windowrulev2 = size 349 177, title:(Picture-in-Picture)
      #windowrulev2 = move 1083 718, title:(Picture-in-Picture)
      
      #windowrulev2 = pin,   class:^(firefox)$, title:^(Picture-in-Picture)$
      #windowrulev2 = float,3 6 class:^(firefox)$, title:^(Picture-in-Picture)$
      #windowrulev2 = pin,   class:^(firefox)$, title:^(Picture-in-Picture)$
      #windowrulev2 = size 800 450, class:^(firefox)$, title:^(Picture-in-Picture)$
     
      #windowrulev2 = workspace 8 silent,initialClass:(vesktop)
      # See https://wiki.hyprland.org/Configuring/Keywords/ for more$ nix-env --delete-generations 14d

      #TODO: Put binds in separate file
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

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1
      #F1-9
      #TODO: Find out why these aren't working on zenbook, need key monitor to see what keys are being pressed (if any)
      bind =, XF86AudioMute, exec,pamixer -t
      bind =, XF86AudioLowerVolume, exec,pamixer -d 9
      bind =, XF86AudioRaiseVolume, exec,pamixer -i 9
      bind =, XF86MonBrightnessDOWN, exec,light  -U .29
      bind =, XF86MonBrightnessUP, exec, light -A 3

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
      #TODO: make workspacee file 
      workspace = 3, default:true, persistent:true
      workspace = 2, rounding:false, decorate:false, gapsin:0, gapsout:0, border:false, decorate:false, persistent:true
      workspace = 8, rounding:false, decorate:false, gapsin:0, gapsout:0, border:false, decorate:false, persistent:true      
      misc{
      disable_autoreload = true
      }

      exec-once = hyprpaper  
      exec-once = hyprpanel
      exec-once = lxqt-policykit-agent #polkit for popsicle
      #exec-once =  clipse -listen  & hyprctl dispatch exec code 
      #exec-once = hyprctl dispatch exec vesktop & hyprctl dispatch exec zen 

  '';
  };
}


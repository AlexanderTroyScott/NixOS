#https://github.com/Alexays/Waybar/wiki/Module:-Hyprland
{ config, lib, pkgs, unstable, hyprland, user, home-manager, ... }:

{
  programs = {
    waybar = {
      enable = true;
      settings = [{
        layer = "top";
        position = "top";
        mod = "dock";
        exclusive = true;
        passthrough = false;
        #gtk-layer-shell = true;
        height = 33;
        #width = 3840;
        modules-left = ["clock" "hyprland/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = ["temperature"
          "custom/power_profile"
          "battery"
          "backlight"
          "pulseaudio"
          "pulseaudio#microphone"
          "tray"
        ];

        tray = {
          icon-size = 15;
          spacing = 10;
        };

        clock = {
          #format = "{: %I:%M %p   %a, %b %e}";
          format= "  {:%OI:%M %p}";
          format-alt="  {:%a, %d %b}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        backlight = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          format-icons = ["󰃞" "󰃟" "󰃠"];
          on-scroll-up = "light -A 1";
          on-scroll-down = "light -U 1";
          min-length = 6;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          tooltip = false;
          format-muted = " Muted";
          on-click = "pavucontrol";
          on-scroll-up = "pamixer -i 5";
          on-scroll-down = "pamixer -d 5";
          scroll-step = 5;
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = ["" "" ""];
          };
        };

        "hyprland/workspaces" = {
          format = "{name}: {icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            active = "";
            default = "";
          };
          persistent-workspaces = {
            "*" = 5;
            "HDMI-A-1" = 3;
          };
        };

        network = {
          format-wifi = "  {signalStrength}%";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{essid} - {ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}:{essid} {ipaddr}/{cidr}";
        };

        bluetooth = {
          format = " {status}";
          format-disabled = "";
          format-connected = " {num_connections}";
          tooltip-format = "{device_alias}";
          tooltip-format-connected = " {device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}";
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = "Mic: {volume}%";
          format-source-muted = "Mic: Muted";
          on-click = "pamixer --default-source -t";
          on-scroll-up = "pamixer --default-source -i 5";
          on-scroll-down = "pamixer --default-source -d 5";
          scroll-step = 5;
        };

        temperature = {
          thermal-zone = 1;
          format = "{temperatureF}°F ";
          critical-threshold = 80;
          format-critical = "{temperatureC}°C ";
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
      }];

      style = ''
* {
  border: none;
  border-radius: 0px;
  font-family: "JetBrainsMono Nerd Font";
  font-weight: bold;
  font-size: 11px;
  min-height: 0;
  transition: 0.3s;
}

window#waybar {
  background: rgba(21, 18, 27, 0);
  color: #cdd6f4;
}

tooltip {
  background: #1e1e2e;
  border-radius: 10px;
  border-width: 1.5px;
  border-style: solid;
  border-color: #11111b;
  transition: 0.3s;
}

#workspaces button {
  padding: 5px;
  color: #313244;
  margin-right: 5px;
}

#workspaces button.active {
  color: #a6adc8;
}

#workspaces button.focused {
  color: #a6adc8;
  background: #eba0ac;
  border-radius: 20px;
}

#workspaces button.urgent {
  color: #11111b;
  background: #a6e3a1;
  border-radius: 20px;
}

#workspaces button:hover {
  background: #11111b;
  color: #cdd6f4;
  border-radius: 20px;
}

#custom-power_profile,
#custom-weather,
#window,
#clock,
#battery,
#pulseaudio,
#network,
#bluetooth,
#temperature,
#workspaces,
#tray,
#backlight {
  background: #1e1e2e;
  opacity: 0.8;
  padding: 0px 10px;
  margin: 0;
  margin-top: 5px;
  border: 1px solid #181825;
}

#temperature {
  border-radius: 20px 0px 0px 20px;
}

#temperature.critical {
  color: #eba0ac;
}

#backlight {
  border-radius: 20px 0px 0px 20px;
  padding-left: 7px;
}

#tray {
  border-radius: 20px;
  margin-right: 5px;
  padding: 0px 4px;
}

#workspaces {
  background: #1e1e2e;
  border-radius: 20px;
  margin-left: 5px;
  padding-right: 0px;
  padding-left: 5px;
}

#custom-power_profile {
  color: #a6e3a1;
  border-left: 0px;
  border-right: 0px;
}

#window {
  border-radius: 20px;
  margin-left: 5px;
  margin-right: 5px;
}

#clock {
  color: #fab387;
  border-radius: 20px;
  margin-left: 5px;
  border-right: 0px;
  transition: 0.3s;
  padding-left: 7px;
}

#network {
  color: #f9e2af;
  border-radius: 20px 0px 0px 20px;
  border-left: 0px;
  border-right: 0px;
}

#bluetooth {
  color: #89b4fa;
  border-radius: 20px;
  margin-right: 10px;
}

#pulseaudio {
  color: #89b4fa;
  border-left: 0px;
  border-right: 0px;
}

#pulseaudio.microphone {
  color: #cba6f7;
  border-left: 0px;
  border-right: 0px;
  border-radius: 0px 20px 20px 0px;
  margin-right: 5px;
  padding-right: 8px;
}

#battery {
  color: #a6e3a1;
  border-radius: 0 20px 20px 0;
  margin-right: 5px;
  border-left: 0px;
}

#custom-weather {
  border-radius: 20px;
  border-right: 0px;
  margin-left: 0px;
}
      '';
    };
  };
}

{ config, lib, pkgs, modulesPath, ... }:

{
    environment.systemPackages = with pkgs; [
  pavucontrol  # GUI volume control
];
hardware.firmware = [
  pkgs.sof-firmware
];
security.rtkit.enable = true;
services = {
    #hardware.bolt.enable = true;
    #getty.autologinUser = "alex";        #auto-login at boot
    #logind.settings.Login = {
    #  HandlePowerKey=hibernate;
    #    HandleLidSwitch=suspend-then-hibernate;
    #    HandleLidSwitchDocked=ignore;
    #    HandleLidSwitchExternalPower=ignore;
    #};
    #logind.extraConfig = ''
        # Suspend then hibernate when the power key is short pressed. Long presses are handled by Bios and will power off.
      #  HandlePowerKey=hibernate
      #  HandleLidSwitch=suspend-then-hibernate
      #  HandleLidSwitchDocked=ignore
      #  HandleLidSwitchExternalPower=ignore
      #'';
    #pcscd.enable = true; #for yubikey but may not have worked
      # Enable sound with pipewire.
  pulseaudio.enable = lib.mkDefault false;
    
  pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;

    #bug fix
    wireplumber = {
        enable = true;
        extraConfig =  {
            "10-disable-camera" =  {
                "wireplumber.profiles" = {
                    main."monitor.libcamera" = "disabled";
                };
            };
            "20-rename-sinks" = {
                "monitor.alsa.rules" = [
                    {
                        matches = [{ "node.name" = "alsa_output.pci-0000_00_1f.3-platform-sof_sdw.pro-output-0"; }];
                        actions.update-props = {
                            "node.description" = "Speakers";
                            "node.nick" = "Speakers";
                        };
                    }
                    {
                        matches = [{ "node.name" = "alsa_output.pci-0000_00_1f.3-platform-sof_sdw.pro-output-2"; }];
                        actions.update-props = {
                            "node.description" = "Headphones";
                            "node.nick" = "Headphones";
                        };
                    }
                    {
                        matches = [{ "node.name" = "alsa_output.pci-0000_00_1f.3-platform-sof_sdw.pro-output-5"; }];
                        actions.update-props = {
                            "node.description" = "HDMI 1";
                            "node.nick" = "HDMI 1";
                        };
                    }
                    {
                        matches = [{ "node.name" = "alsa_output.pci-0000_00_1f.3-platform-sof_sdw.pro-output-6"; }];
                        actions.update-props = {
                            "node.description" = "HDMI 2";
                            "node.nick" = "HDMI 2";
                        };
                    }
                    {
                        matches = [{ "node.name" = "alsa_output.pci-0000_00_1f.3-platform-sof_sdw.pro-output-7"; }];
                        actions.update-props = {
                            "node.description" = "HDMI 3";
                            "node.nick" = "HDMI 3";
                        };
                    }
                    {
                        matches = [{ "node.name" = "alsa_output.pci-0000_00_1f.3-platform-sof_sdw.pro-output-31"; }];
                        actions.update-props = {
                            "node.description" = "IEC958";
                            "node.nick" = "IEC958";
                        };
                    }
                ];
            };
        };
      };
  };
    #logind.lidSwitch = "ignore";           # Laptop does not go to sleep when lid is closed
    #auto-cpufreq.enable = true;
    blueman.enable = true;
  };
}
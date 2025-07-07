services = {
    #hardware.bolt.enable = true;
    #getty.autologinUser = "alex";        #auto-login at boot
    logind.extraConfig = ''
        # Suspend then hibernate when the power key is short pressed. Long presses are handled by Bios and will power off.
        HandlePowerKey=hibernate
        HandleLidSwitch=suspend-then-hibernate
        HandleLidSwitchDocked=ignore
        HandleLidSwitchExternalPower=ignore
      '';
    #pcscd.enable = true; #for yubikey but may not have worked
    pipewire = {
        enable = true;
        audio.enable = true;
        alsa = {
            enable = true;
            support32Bit = true;
        };
        pulse.enable = true;
        jack.enable = true;
        wireplumber = {
            enable = true;
            extraConfig =  {
                "10-disable-camera" =  {
                    "wireplumber.profiles" = {
                        main."monitor.libcamera" = "disabled";
                    };
                };
            };
        };
    };
    #logind.lidSwitch = "ignore";           # Laptop does not go to sleep when lid is closed
    #auto-cpufreq.enable = true;
    blueman.enable = true;
  };
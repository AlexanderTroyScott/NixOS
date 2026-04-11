{ config, lib, pkgs, modulesPath, ... }:

{
    environment.systemPackages = with pkgs; [
  pipewire
  wireplumber
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
  pulseaudio.enable = false;
    
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
        };
      };
  };
    #logind.lidSwitch = "ignore";           # Laptop does not go to sleep when lid is closed
    #auto-cpufreq.enable = true;
    blueman.enable = true;
  };
}
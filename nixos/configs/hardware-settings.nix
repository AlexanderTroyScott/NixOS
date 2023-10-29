{ config, pkgs, ... }:

{
boot = {
    # Boot options
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = ["!" "thunderbolt"];
    kernelParams = [ "bolt" "i915.force_probe=46a6" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
  #boot.kernelParams = [ ]; #12th gen alder lake; see https://nixos.wiki/wiki/Intel_Graphics

  #Graphics Settings
  hardware = {
    opengl.enable = true;
  };
  hardware.opengl.driSupport32Bit = true;
  hardware.steam-hardware.enable = true;
  #Intel CPU opencl support
  hardware.opengl.extraPackages = with pkgs; [
  intel-media-driver        #GPU acceleration 
  intel-compute-runtime     #OpenComputeLanguage
  intel-ocl                 #OpenComputeLanguage
  # vaapiIntel              #Drivers for older intel CPUs (gen 7 or 8), not needed for 12th gen
  ];
  environment.systemPackages = with pkgs; [
    undervolt   #undervolting
  ];
  
  #Power Optimization
  boot.kernel.sysctl."vm.dirty_writeback_centisecs" = 1500; # 15 seconds
  #TouchPad
  #services.xserver.libinput.enable = true; #Expected to be enabled by default
  #Power Settings
  services.power-profiles-daemon.enable = false;
  services.tlp = {
  enable = true;
  settings = {
    CPU_BOOST_ON_BAT = "0";
    SATA_LINKPWR_ON_AC = "med_power_with_dipm";
    SATA_LINKPWR_ON_BAT = "min_power";
    PCIE_ASPM_ON_AC = "default";
    PCIE_ASPM_ON_BAT = "powersave";
    WIFI_PWR_ON_AC = "off";
    WIFI_PWR_ON_BAT = "on";
    RUNTIME_PM_ON_AC = "on";
    RUNTIME_PM_ON_BAT = "auto";
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    ENERGY_PERFORMANCE_PREFERENCE_ON_BAT = "power";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
  };
};
  services.undervolt = {
    enable = true;
    tempBat = -25;
#    package = pkgs.intel-undervolt;
#    coreOffset = -1;
#    cacheOffset = -1;
#    gpuOffset = -100;
  };

  services = {
    hardware.bolt.enable = true;
    getty.autologinUser = "alex";        #auto-login at boot
    logind.extraConfig = ''
        # Suspend then hibernate when the power key is short pressed. Long presses are handled by Bios and will power off.
        HandlePowerKey=hibernate
        HandleLidSwitch=suspend-then-hibernate
        HandleLidSwitchDocked=ignore
        HandleLidSwitchExternalPower=ignore
      '';
    pcscd.enable = true; #for yubikey but may not have worked
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    #logind.lidSwitch = "ignore";           # Laptop does not go to sleep when lid is closed
    auto-cpufreq.enable = true;
    blueman.enable = true;
  };
  hardware = {
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };

 programs = {
    dconf.enable = true;
    light.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    #sway.enable = true;
    #hyprland.package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };

  environment.variables.BROWSER = "${pkgs.vivaldi}/bin/vivaldi"; #set default browser
  
  environment.sessionVariables = {
    #WLR_NO_HARDWARE_CURSORS = "1"; 
    #if cursor is invisible
    NIXOS_OZONE_WL = "1";
  };

  security.pam.services.swaylock = {
    text = ''
    auth include login
    '';
  };


}
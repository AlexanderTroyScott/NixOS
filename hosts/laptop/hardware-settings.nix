{ config, pkgs, ... }:

{
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
    #mesa        #Graphics
    undervolt   #undervolting
  ];
  boot.kernelParams = [ "i915.force_probe=46a6" ]; #12th gen alder lake; see https://nixos.wiki/wiki/Intel_Graphics

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

}

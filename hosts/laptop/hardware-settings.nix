{ config, pkgs, ... }:

{
  #Graphics Settings
  hardware = {
    opengl.enable = true;
  };
  environment.systemPackages = [
    pkgs.mesa
  ];


  #Power Optimization
  boot.kernel.sysctl."vm.dirty_writeback_centisecs" = 1500; # 15 seconds
  environment.systemPackages = with pkgs; [
    undervolt
  ];
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

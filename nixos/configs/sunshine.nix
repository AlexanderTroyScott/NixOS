{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  hyprland,
  home-manager,
  ...
}: let 
    configFile = pkgs.writeTextDir "/home/alex/.config/sunshine/sunshine.conf"
        ''
        origin_web_ui_allowed=wan
        encoder=vaapi
        adapter_name = /dev/dri/renderD128
        #output_name = HEADLESS-2
#        WLR_BACKENDS=headless
        '';
        #encoder = quicksync
        #adapter_name = /dev/dri/renderD128
        #capture = wlr
  in {
#home-manager.users.alex = { pkgs, ... }: {
#  home.packages = with pkgs; [ 
#    sunshine 
#    xorg.xrandr 
#    gnome.gdm 
#    ffmpeg-full 
#    mesa
#    avahi       
#    libappindicator-gtk3 # This is an example, actual package name might vary
#    gtk3 
#  ];
#  home.stateVersion = "23.05";
#};
 
  networking.firewall = {
      enable = false;
    allowedTCPPortRanges = [ { from = 0; to = 65535; } ];
    allowedUDPPortRanges = [ { from = 0; to = 65535; } ];
  };
 
users.users = {
    alex = {
      #initialPassword = "password";
      isNormalUser = true;
      home  = "/home/alex";
      password = "password";
      description  = "user account";
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "wheel" "networkmanager" "video" "audio" "sound" "input" "render"];
    };
    sunshine = {
      #initialPassword = "password";
      isNormalUser = true;
      home  = "/home/sunshine";
      password = "password";
      description  = "user account";
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "wheel" "networkmanager" "video" "audio" "sound" "input" "render"];
    };
  };
  security.sudo.extraRules = [
    {    
      users = [ "alex" ];
      commands = [
        {  
            command = "ALL" ;
            options= [ "NOPASSWD" ];
        }
      ];
    }
  ];
  services.avahi = { 
    enable = true;
    publish.userServices = true;
    nssmdns4 = true;
  };
programs.dconf.enable = true;
  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+p";
    #capabilities = "-r";
    source = "${pkgs.sunshine}/bin/sunshine";
  };
systemd.services.headless = {
  wantedBy = [ "multi-user.target" ];  # Ensure this starts with the graphical environment
  after = [ "network.target" ];     # Ensures it starts after graphical.target
  #partOf = [ "graphical-session.target" ];
  serviceConfig = {
    ExecStart = "${pkgs.hyprland}/bin/Hyprland";
    Restart = "on-failure";
    RestartSec = "5s";
    User = "alex";
    # Ensure these are necessary or correct them as needed
    Environment = [  "XDG_RUNTIME_DIR=/run/user/1000"
    "WLR_BACKENDS=headless"
    "WAYLAND_DISPLAY=headless" 
    "PATH=${pkgs.hyprland}/bin/Hyprland/bin"
     ];
  };
};

systemd.services.hyprland = {
  wantedBy = [ "multi-user.target" ];  # Ensure this starts with the graphical environment
     # Ensures it starts after graphical.target
  #partOf = [ "graphical-session.target" ];
  #after = [ "headless.service"];
   #requires = [ "headless.service"];
  serviceConfig = {
    ExecStart = "${pkgs.hyprland}/bin/Hyprland";
    Restart = "on-failure";
    RestartSec = "5s";
  
    User = "alex";
    # Ensure these are necessary or correct them as needed
    Environment = [  "XDG_RUNTIME_DIR=/run/user/1000"];
  };
};
  systemd.services.sunshine = {
    description = "Sunshine server";
    wantedBy = [ "multi-user.target" ];
    #startLimitIntervalSec = 500;
    #startLimitBurst = 5;
    after = [ "headless.service"];
    requires = [ "headless.service"];

    serviceConfig = {
      User="alex";
      ExecStart = "${pkgs.sunshine}/bin/sunshine";
      Restart = "on-failure";
      RestartSec = "30s";
          CapabilityBoundingSet = "CAP_SYS_ADMIN";
    AmbientCapabilities = "CAP_SYS_ADMIN";
    Environment = [  "WAYLAND_DISPLAY=wayland-1"
    "XDG_RUNTIME_DIR=/run/user/1000"];
    };
  };

  services.udev.extraRules = ''
      KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
    '';
}

# Inspired from https://github.com/LizardByte/Sunshine/blob/5bca024899eff8f50e04c1723aeca25fc5e542ca/packaging/linux/sunshine.service.in

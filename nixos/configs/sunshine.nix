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
    configFile = pkgs.writeTextDir "config/sunshine.conf"
        ''
        origin_web_ui_allowed=wan
        encoder=vaapi
        adapter_name = /dev/dri/renderD128
        '';
        #encoder = quicksync
        #adapter_name = /dev/dri/renderD128
        #capture = wlr
  in {
home-manager.users.alex = { pkgs, ... }: {
  home.packages = with pkgs; [ 
    sunshine 
    xorg.xrandr 
    gnome.gdm 
    ffmpeg-full 
    mesa
    avahi       
    libappindicator-gtk3 # This is an example, actual package name might vary
    gtk3 
  ];
  home.stateVersion = "23.05";
};
 
  networking.firewall = {
      enable = false;
    allowedTCPPortRanges = [ { from = 0; to = 65535; } ];
    allowedUDPPortRanges = [ { from = 0; to = 65535; } ];
  };

  programs.hyprland = {
    enable = true;  
    package = inputs.hyprland.packages.${pkgs.system}.hyprland; 
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
  };
  security.sudo.extraRules = [
    {  
      users = [ "alex" ];
      commands = [
        { 
            command = "ALL" ;
        #    options= [ "NOPASSWD" ];
        }
      ];
    }
  ];
  services.avahi = { 
    enable = true;
    publish.userServices = true;
    nssmdns4 = true;
  };
  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+p";
    #capabilities = "-r";
    source = "${pkgs.sunshine}/bin/sunshine";
  };

  systemd.user.services.sunshine = {
    description = "Sunshine server";
    wantedBy = [ "graphical-session.target" ];
    startLimitIntervalSec = 500;
    startLimitBurst = 5;
    partOf = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${config.security.wrapperDir}/sunshine ${configFile}/config/sunshine.conf";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };

  services.udev.extraRules = ''
      KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
    '';
}

# Inspired from https://github.com/LizardByte/Sunshine/blob/5bca024899eff8f50e04c1723aeca25fc5e542ca/packaging/linux/sunshine.service.in

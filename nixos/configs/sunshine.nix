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
        '';
  in {

    #users.users.sunshine = with pkgs; [
    #  sunshine
    #  xorg.xrandr
    #  gnome.gdm
    #];
home-manager.users.alex = { pkgs, ... }: {
  home.packages = [ pkgs.sunshine pkgs.xorg.xrandr pkgs.gnome.gdm];
  home.stateVersion = "23.05";
  };
    # X and audio
    sound.enable = true;
    hardware.pulseaudio.enable = true;
    security.rtkit.enable = true;
    networking.firewall = {
      # enable = true;
      allowedTCPPortRanges = [ { from = 0; to = 65535; } ];
      allowedUDPPortRanges = [ { from = 0; to = 65535; } ];
    };
environment.variables = {
    VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
  };

services.xserver = {
    enable = true;
    xkb = {
      #variant = "qwerty";
      layout = "us";
    };
    videoDrivers = ["modesetting" "fbdev"];
    
    displayManager.gdm.enable = true;
    displayManager.defaultSession = "gnome";

    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "alex"; # user must exists

    desktopManager.gnome.enable = true;
       # Dummy screen
};
users.users = {
        alex = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "";
      isNormalUser = true;
      home  = "/home/alex";
      password = "";
        description  = "Sunshine Server";
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "wheel" "networkmanager" "video" "audio" "sound" "input"];
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
  #services.avahi.enable = true;
  services.avahi.publish.userServices = true;
  services.avahi.nssmdns4 = true;
security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+p";
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

  #services.udev.extraRules = ''
  #    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  #  '';

  services.udev.extraRules = ''
      KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
    '';  
}
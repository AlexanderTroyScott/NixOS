{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  hyprland,
  home-manager,
  ...
}: {

    environment.systemPackages = with pkgs; [
      sunshine
      avahi
      xorg.xrandr

    ]
services.xserver = {
    enable = true;

    #videoDrivers = ["nvidia"];
    
    displayManager.gdm.enable = true;
    displayManager.defaultSession = "gnome";

    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "sunshine"; # user must exists

    desktopManager.gnome.enable = true;
};
users.users = {
        sunshine = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "wheel" "networkmanager" "video" "audio" "camera" "input" "docker"];
    };
};
   security.sudo.extraRules = [
        {  
            users = [ "sunshine" ];
            commands = [
                { 
                    command = "ALL" ;
                    options= [ "NOPASSWD" ];
                }
            ];
        }
    ];
  services.avahi.enable = true;
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
        ExecStart = "${config.security.wrapperDir}/sunshine";
        Restart = "on-failure";
        RestartSec = "5s";
    };
};

  services.udev.extraRules = ''
      KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
    '';
}
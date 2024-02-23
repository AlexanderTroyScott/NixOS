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
    avahi       
    libappindicator-gtk3 # This is an example, actual package name might vary
    gtk3 
  ];
  home.stateVersion = "23.05";
  };
    # X and audio
    #sound.enable = true;
    #hardware.pulseaudio.enable = true;
    #security.rtkit.enable = true;
    networking.firewall = {
       enable = true;
      allowedTCPPortRanges = [ { from = 0; to = 65535; } ];
      allowedUDPPortRanges = [ { from = 0; to = 65535; } ];
    };
#environment.variables = {
#    VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
#  };
  programs.hyprland = {
    enable = true;  
    package = inputs.hyprland.packages.${pkgs.system}.hyprland; 
  };
 
 #services = {
 # xserver = {
    #enable = true; # Enable the X server
    #xkb.layout = "us";
    #videoDrivers = ["intel" "i915" "modesetting" "fbdev"];
    
    #displayManager = {
     # gdm = {
    #    enable = true; # Ensure GDM is enabled
     #   wayland = true; # Indicate preference for Wayland with GDM
     # };
      
     # autoLogin = {
      #  enable = true;
      #  user = "alex";
      #};
    #};
    #desktopManager.gnome.enable = true;
    #Dummyscreen
 # };
 #};

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
  services.avahi.enable = true;
  services.avahi.publish.userServices = true;
  services.avahi.nssmdns4 = true;
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

  #services.udev.extraRules = ''
  #    KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
  #  '';  
}
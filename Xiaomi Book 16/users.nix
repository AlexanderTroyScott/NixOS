{ config, pkgs, ... }:

{
 users.users.alex = {
    isNormalUser = true;
    description = "Alex Scott";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      discord
      steam
      pcloud
      opera
      vscode
    #  thunderbird
    ];
  };
}

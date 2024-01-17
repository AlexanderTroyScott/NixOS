{ config, pkgs, ... }:
{
    packages = with pkgs; [
        vscode
    ];
    programs.vscode = {
      enable = true;

    };   
}
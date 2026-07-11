{ config, lib, pkgs, ... }:
{
  stylix.targets.vscode.enable = true;
  programs.vscode.enable = true;

    programs.vscode.profiles.default = {
      enableUpdateCheck = true;
      enableExtensionUpdateCheck = true;
      extensions = with pkgs.vscode-extensions; [
        github.copilot
        github.github-vscode-theme
        github.vscode-github-actions
        bbenoist.nix
      ];
      userSettings = {
         "window.titleBarStyle" = "custom";
         "workbench.colorTheme" = lib.mkForce "Amoled Github";
         "github.copilot.enable" = {
           "*" = true;
           "plaintext" = false;
           "markdown" = true;
           "scminput" = false;
         };
      };
    };   
}
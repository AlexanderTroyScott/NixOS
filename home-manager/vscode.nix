{ config, pkgs, ... }:
{
  stylix.targets.vscode.enable =false;

    programs.vscode = {
      enable = true;
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
         "workbench.colorTheme" = "Amoled Github";
         "editor.fontFamily" = "'M+1Code Nerd Font','Droid Sans Mono', 'monospace', monospace";
         "github.copilot.enable" = {
           "*" = true;
           "plaintext" = false;
           "markdown" = true;
           "scminput" = false;
         };
      };
    };   
}
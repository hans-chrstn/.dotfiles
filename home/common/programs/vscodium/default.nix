{ pkgs, ... }:
{

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc-icons
      catppuccin.catppuccin-vsc
      vscodevim.vim
    ];

    userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";
      "window.menuBarVisibility" = "toggle";
      "workbench.startupEditor" = "none";
    };
  };
}

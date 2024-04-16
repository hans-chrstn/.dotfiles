{ config, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      asvetliakov.vscode-neovim
      yzhang.markdown-all-in-one
      jdinhlife.gruvbox
    ];
  }; 
}

{ config, pkgs, ... }:

{
  programs.neovim = {
    defaultEditor = true;
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    
    extraPackages = with pkgs; [
      xclip
      wl-clipboard
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = gruvbox-nvim;
        config = "colorscheme gruvbox";
      }
    ];
  };
}

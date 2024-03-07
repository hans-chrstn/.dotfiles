{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    
  ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {

    };

    initExtra = ''
      source ~/.dotfiles/home/profiles/default/configs/zsh/.p10k.zsh

    '';

    plugins = [ 
      {
       name = "powerlevel10k";
       src = pkgs.zsh-powerlevel10k;
       file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

  };
  programs.starship = {
    enable = true;
  };
}

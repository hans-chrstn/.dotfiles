{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    lsd
  ];
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      ls = "lsd";
      l = "ls -l";
      la = "ls -la";
      ip = "ip --color=auto";
      cat = "bat";
      c = "code";
    };
  };
  programs.starship = {
    enable = true;
  };
}

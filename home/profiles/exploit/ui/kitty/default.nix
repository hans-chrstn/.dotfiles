{ inputs, pkgs, ... }:

{
  home.file.".config/kitty" = {
    source = ./config;

  };

  programs.kitty = {
    enable = true;
    #theme = "N0tch2k";
    #extraConfig = ''
    #  window_margin_width 9
    #  background_opacity 0.78
    #  #foreground #baafa9
    #  background #010100
    #'';

  };
  


}

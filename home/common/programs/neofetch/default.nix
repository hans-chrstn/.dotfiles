{ config, inputs, pkgs, ... }:

{
  xdg.configFile."neofetch" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/neofetch/config/";
  };

  home.packages = [
    pkgs.neofetch
  ];
}

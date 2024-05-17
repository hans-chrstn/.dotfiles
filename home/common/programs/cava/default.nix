{ config, ... }:

{

  programs.cava = {
    enable = true;
  };

  xdg.configFile."cava" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/cava/config";
  };
}

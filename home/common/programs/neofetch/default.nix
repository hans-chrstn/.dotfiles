{ config, ... }:

{
  xdg.configFile."neofetch" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/neofetch/config/";
  };

}

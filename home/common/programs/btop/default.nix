{ config, ... }:

{

  programs.btop = {
    enable = true;
  };

  xdg.configFile."btop" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/btop/config";
  };
}

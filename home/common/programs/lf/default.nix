{ config, ... }:

{

  xdg.configFile."lf" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/lf/config";
  };

  programs.lf = {
    enable = false;
  };
}

{ config, ... }:

{

  programs.fuzzel = {
    enable = true;
  };

  xdg.configFile."fuzzel" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/fuzzel/config";
  };

}

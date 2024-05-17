{ config, ... }:

{

  programs.obs-studio = {
    enable = true;
  };

  xdg.configFile."obs-studio/themes" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/obs/config/";
  };
}

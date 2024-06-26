{ config, ... }:
{
  xdg.configFile."emacs" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/emacs/config/";
  };

  programs.emacs = {
    enable = true;
  };
}

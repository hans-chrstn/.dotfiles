{ config, ... }:

{

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "${config.home.homeDirectory}/.config/themes/catppuccin_mocha.theme";
    };
  };

  xdg.configFile."btop/themes" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/btop/config/themes";
  };
}

{ config, ... }: 
{
  xdg.configFile."greetd" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/profiles/default/ui/greetd/config/";
  };
}

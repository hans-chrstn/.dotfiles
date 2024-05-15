{ config, ... }:

{

  xdg.configFile."lf" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config;
  };  

  programs.lf = {
    enable = true;
  };
}

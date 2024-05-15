{ config, ... }:

{

  xdg.configFile."lf" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config;
  };  
}

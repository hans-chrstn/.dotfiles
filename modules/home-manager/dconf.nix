{ lib, config, ... }:
with lib;
let
 cfg = config.mod.dconf;
in
{
  options.mod.dconf = {
    enable = mkEnableOption "Enable dconf config";
    dark-scheme = mkEnableOption "Enable dark gnome scheme";
  };

  config = mkIf cfg.enable {
    dconf = {
      enable = true;
      settings = mkIf cfg.dark-scheme {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    };
  };
}

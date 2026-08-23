{
  lib,
  config,
  ...
}: let
  cfg = config.dotfiles.programs.dconf;
in {
  options.dotfiles.programs.dconf = {
    enable = lib.mkEnableOption "Enable dconf config";
    dark-scheme = lib.mkEnableOption "Enable dark gnome scheme";
  };

  config = lib.mkIf cfg.enable {
    dconf = {
      enable = true;
      settings = lib.mkIf cfg.dark-scheme {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    };
  };
}

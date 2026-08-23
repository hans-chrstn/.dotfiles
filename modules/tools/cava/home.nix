{
  lib,
  config,
  ...
}: let
  cfg = config.dotfiles.programs.cava;
in {
  options.dotfiles.programs.cava = {
    enable = lib.mkEnableOption "Enable the cava feature";
  };

  config = lib.mkIf cfg.enable {
    programs.cava = {
      enable = true;
    };

    xdg.configFile."cava" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/home-manager/cava/config";
    };
  };
}

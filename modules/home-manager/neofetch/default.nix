{ pkgs, lib, config, ... }:
let
  cfg = config.mod.programs.neofetch;
in
{
  options.mod.programs.neofetch = {
    enable = lib.mkEnableOption "Enable the neofetch feature";
    # enableXserver = lib.mkOption { type = lib.types.bool; default = true; };
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."neofetch" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/home-manager/neofetch/config/";
    };

    home.packages = [
      pkgs.neofetch
    ];
  };
}

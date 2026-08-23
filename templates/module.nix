{
  config,
  lib,
  ...
}: let
  cfg = config.dotfiles.NEW_OPTION_PATH;
in {
  options.dotfiles.NEW_OPTION_PATH.enable = lib.mkEnableOption "NEW_MODULE_NAME";

  config = lib.mkIf cfg.enable {};
}

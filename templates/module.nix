{ lib, config, ... }:
let
  cfg = config.mod.NEW_MODULE_NAME;
in
{
  options.mod.NEW_MODULE_NAME = {
    enable = lib.mkEnableOption "Enable the NEW_MODULE_NAME feature";
    # enableXserver = lib.mkOption { type = lib.types.bool; default = true; };
  };

  config = lib.mkIf cfg.enable {
    # for example:
    # environment.systemPackages = [ pkgs.my-package ];
    # services.xserver.enable = cfg.enableXserver;
  };
}

{ lib, config, ... }:
let
  cfg = config.mod.hardware.intel;
in
{
  options.mod.hardware.intel = {
    enable = lib.mkEnableOption "Enable the intel feature";
    # enableXserver = lib.mkOption { type = lib.types.bool; default = true; };
  };

  config = lib.mkIf cfg.enable {
    # for example:
    # environment.systemPackages = [ pkgs.my-package ];
    # services.xserver.enable = cfg.enableXserver;
  };
}

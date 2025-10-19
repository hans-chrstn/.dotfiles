{ lib, config, ... }:
let
  cfg = config.mod.hardware.location;
in
{
  options.mod.hardware.location = {
    enable = lib.mkEnableOption "Enable the location feature";
  };

  config = lib.mkIf cfg.enable {
    location.provider = "geoclue2";
    services.geoclue2.enable = true;
  };
}

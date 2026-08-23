{
  lib,
  config,
  ...
}: let
  cfg = config.dotfiles.hardware.location;
in {
  options.dotfiles.hardware.location = {
    enable = lib.mkEnableOption "Enable the location feature";
  };

  config = lib.mkIf cfg.enable {
    location.provider = "geoclue2";
    services.geoclue2.enable = true;
  };
}

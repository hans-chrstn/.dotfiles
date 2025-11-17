{
  lib,
  config,
  ...
}: let
  cfg = config.mod.samson-q2u;
in {
  options.mod.samson-q2u = {
    enable = lib.mkEnableOption "Enable the samson-q2u feature";
  };

  config = lib.mkIf cfg.enable {
    services.easyeffects = {
      enable = true;
      extraPresets = {};
      preset = '''';
    };
  };
}

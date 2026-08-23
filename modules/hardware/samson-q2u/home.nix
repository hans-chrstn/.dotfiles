{
  lib,
  config,
  ...
}: let
  cfg = config.dotfiles.hardware.samson-q2u;
in {
  options.dotfiles.hardware.samson-q2u = {
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

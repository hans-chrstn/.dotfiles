{
  lib,
  config,
  ...
}: let
  cfg = config.mod.programs.obs;
in {
  options.mod.programs.obs = {
    enable = lib.mkEnableOption "Enable the obs feature";
  };

  config = lib.mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
    };
  };
}

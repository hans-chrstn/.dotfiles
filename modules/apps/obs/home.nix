{
  lib,
  config,
  pkgs,
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
      plugins = with pkgs.obs-studio-plugins; [
        obs-vertical-canvas
        obs-multi-rtmp
      ];
    };
  };
}

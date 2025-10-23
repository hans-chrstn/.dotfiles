{
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.mod.wm.mangowc;
in {
  imports = [
    inputs.mango.nixosModules.mango
  ];
  options.mod.wm.mangowc = {
    enable = lib.mkEnableOption "Enable the mangowc feature";
  };

  config = lib.mkIf cfg.enable {
    programs.mango.enable = true;
  };
}

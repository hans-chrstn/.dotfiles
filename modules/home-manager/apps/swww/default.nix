{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.swww;
in
{
  options.mod.swww = {
    enable = mkEnableOption "Enable swww config and it's best values";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.swww
    ];
  };
}

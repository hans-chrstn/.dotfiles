{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.vivaldi;
in
{
  options.mod.vivaldi = {
    enable = mkEnableOption "Enable vivaldi";
  };

  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.vivaldi;
    };
  };
}

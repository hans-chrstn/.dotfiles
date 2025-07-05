{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.firefox;
in
{
  options.mod.firefox = {
    enable = mkEnableOption "Enable firefox config and it's best values";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-beta;
    };
  };
}

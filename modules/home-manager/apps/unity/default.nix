{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.unity;
in
{
  options.mod.unity = {
    enable = mkEnableOption "Enable unity";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (pkgs.unityhub.override {

        extraLibs = unityhubPkgs: [

        ];
        extraPkgs = fhsPkgs: [
        ];

      })
    ];
  };
}

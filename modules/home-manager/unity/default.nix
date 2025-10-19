{ lib, pkgs, config, ... }:
let
 cfg = config.mod.programs.unity;
in
{
  options.mod.programs.unity = {
    enable = lib.mkEnableOption "Enable unity";
  };

  config = lib.mkIf cfg.enable {
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

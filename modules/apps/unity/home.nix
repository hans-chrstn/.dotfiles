{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.dotfiles.programs.unity;
in {
  options.dotfiles.programs.unity = {
    enable = lib.mkEnableOption "Enable unity";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (pkgs.unityhub.override {
        extraLibs = _unityhubPkgs: [
        ];
        extraPkgs = _fhsPkgs: [
        ];
      })
    ];
  };
}

{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.minecraft;
in
{
  options.mod.minecraft = {
    enable = mkEnableOption "Enable minecraft config and it's best values";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (prismlauncher.override {
        jdks = [
          graalvm-ce
          zulu8
          zulu17
          zulu
        ];
      })
    ];
  };
}

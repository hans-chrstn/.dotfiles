{ inputs, lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.hyprlax;
in
{
  options.mod.hyprlax = {
    enable = mkEnableOption "Enable hyprlax";
  };

  config = mkIf cfg.enable {
  };
}

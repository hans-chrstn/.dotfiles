{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.nix-index;
in
{
  options.mod.nix-index = {
    enable = mkEnableOption "Enable nix-index config and it's best values";
  };

  config = mkIf cfg.enable {
    programs.nix-index.enable = true;
  };
}

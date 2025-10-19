{ lib, config, ... }:
let
 cfg = config.mod.programs.nix-index;
in
{
  options.mod.programs.nix-index = {
    enable = lib.mkEnableOption "Enable nix-index config and it's best values";
  };

  config = lib.mkIf cfg.enable {
    programs.nix-index.enable = true;
  };
}

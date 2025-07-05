{ lib, config, ... }:
with lib;
let
 cfg = config.mod.direnv;
in
{
  options.mod.direnv = {
    enable = mkEnableOption "Enable nix-direnv and integration";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };
  };
}

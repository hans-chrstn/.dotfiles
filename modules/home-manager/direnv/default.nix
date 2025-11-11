{
  lib,
  config,
  ...
}: let
  cfg = config.mod.programs.direnv;
in {
  options.mod.programs.direnv = {
    enable = lib.mkEnableOption "Enable nix-direnv and integration";
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      # enableFishIntegration = true;
      nix-direnv.enable = true;
    };
  };
}

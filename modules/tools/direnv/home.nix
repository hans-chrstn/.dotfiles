{
  lib,
  config,
  ...
}: let
  cfg = config.dotfiles.programs.direnv;
in {
  options.dotfiles.programs.direnv = {
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

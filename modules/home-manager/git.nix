{ lib, config, ... }:
with lib;
let
 cfg = config.mod.git;
in
{
  options.mod.git = {
    enable = mkEnableOption "Enable git config";
    userName = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "userName or else Bob";
    };
    userEmail = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "userEmail or else Bob@gmail.com";
    };
  };

  config = mkIf cfg.enable (
    mkMerge [
      {
        programs.git = {
          enable = true;
          lfs.enable = true;
        };
      }
      (mkIf (cfg.userName != null) {
        programs.git.userName = cfg.userName;
      })
      (mkIf (cfg.userEmail != null) {
        programs.git.userEmail = cfg.userEmail;
      })
    ]
  );
}

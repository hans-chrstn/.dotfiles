{
  lib,
  config,
  ...
}: let
  cfg = config.mod.programs.git;
in {
  options.mod.programs.git = {
    enable = lib.mkEnableOption "Enable git config";
    userName = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "userName or else Bob";
    };
    userEmail = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "userEmail or else Bob@gmail.com";
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        programs.git = {
          enable = true;
          lfs.enable = true;
        };
      }
      (lib.mkIf (cfg.userName != null) {
        programs.git.settings.user.name = cfg.userName;
      })
      (lib.mkIf (cfg.userEmail != null) {
        programs.git.settings.user.email = cfg.userEmail;
      })
    ]
  );
}

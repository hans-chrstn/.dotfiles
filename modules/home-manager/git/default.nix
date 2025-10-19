{ lib, config, ... }:
let
 cfg = config.mod.programs.git;
in
{
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
    enableGh = lib.mkOption {
      type = lib.types.nullOr lib.types.bool;
      default = null;
      description = "Enable gh command";
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
        programs.git.userName = cfg.userName;
      })
      (lib.mkIf (cfg.userEmail != null) {
        programs.git.userEmail = cfg.userEmail;
      })
      (lib.mkIf (cfg.enableGh != null) {
        programs.gh = {
          enable = true;
          settings = {
            theme = "catppuccin-mocha";
            font-size = 10;
            keybind = [
              "ctrl+h=goto_split:left"
              "ctrl+l=goto_split:right"
            ];
          };
        };
      })
    ]
  );
}

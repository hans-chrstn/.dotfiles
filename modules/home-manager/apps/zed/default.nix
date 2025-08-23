{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.zed;
in
{
  options.mod.zed = {
    enable = mkEnableOption "Enable zed editor";
  };

  config = mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
      extensions = [
        "nix"
        "csharp"
        "gdscript"
        "java"
      ];
      userSettings = {
        features = {
          copilot = false;
        };
        telemetry = {
          diagnostics = false;
          metrics = false;
        };
        vim_mode = true;
      };
    };
  };
}

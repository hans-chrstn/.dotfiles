{
  lib,
  config,
  ...
}: let
  cfg = config.mod.programs.nyxt;
in {
  options.mod.programs.nyxt = {
    enable = lib.mkEnableOption "Enable the nyxt feature";
  };

  config = lib.mkIf cfg.enable {
    programs.nyxt = {
      enable = true;
      config = ''
        (define-configuration buffer
          ((default-modes
            (pushnew 'nyxt/mode/vi:vi-normal-mode %slot-value%))))
      '';
    };
  };
}

{ lib, config, ... }:
with lib;
let
 cfg = config.mod.emacs;
in
{
  options.mod.emacs = {
    enable = mkEnableOption "Enable emacs and custom configs";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
    };
  };
}

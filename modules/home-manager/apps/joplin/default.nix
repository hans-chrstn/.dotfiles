{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.joplin;
in
{
  options.mod.joplin = {
    enable = mkEnableOption "Enable joplin";
  };

  config = mkIf cfg.enable {
    programs.joplin-desktop = {
      enable = true;
      extraConfig = {
        "markdown.plugin.mark" = true;
        newNoteFocus = "title";
      };
    };
  };
}

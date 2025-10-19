{ lib, config, ... }:
let
 cfg = config.mod.programs.joplin;
in
{
  options.mod.programs.joplin = {
    enable = lib.mkEnableOption "Enable joplin";
  };

  config = lib.mkIf cfg.enable {
    programs.joplin-desktop = {
      enable = true;
      extraConfig = {
        "markdown.plugin.mark" = true;
        newNoteFocus = "title";
      };
    };
  };
}

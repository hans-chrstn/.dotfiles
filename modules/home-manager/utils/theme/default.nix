{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.theme;
in
{
  options.mod.theme = {
    enable = mkEnableOption "Enable Kanagawa / Bibata theme";
  };

  config = mkIf cfg.enable {
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 22;
    };
    gtk = {
      enable = true;
      theme = {
        name = "Kanagawa";
        package = pkgs.kanagawa-gtk-theme;
      };

      iconTheme = {
        name = "Kanagawa";
        package = pkgs.kanagawa-icon-theme;
        # package = pkgs.tela-circle-icon-theme;
      };

      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 22;
      };
    };
  };
}

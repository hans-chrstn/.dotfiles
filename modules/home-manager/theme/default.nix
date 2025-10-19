{ lib, pkgs, config, ... }:
let
 cfg = config.mod.programs.theme;
in
{
  options.mod.programs.theme = {
    enable = lib.mkEnableOption "Enable Kanagawa / Bibata theme";
  };

  config = lib.mkIf cfg.enable {
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 22;
    };
    gtk = {
      enable = true;
      theme = {
        name = "Breeze";
        package = pkgs.kdePackages.breeze-gtk;
      };

      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };

      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 22;
      };
    };
  };
}

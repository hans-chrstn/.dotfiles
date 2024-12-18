{ pkgs, ... }:

{
  services.xserver.enable = true;

  xdg = {
    icons.enable = true;
    portal = {
      enable = true;
      extraPortals = [ 
        pkgs.xdg-desktop-portal-gtk
      ];
      config = {
        common = {
          default = [
            "gtk"
          ];
        };
      };
    };
  };
}

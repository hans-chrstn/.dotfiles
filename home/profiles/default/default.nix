{ pkgs, ... }:

{
  imports = [
    ./programs.nix
    ./overlays.nix
    ./programs
    ./common
    ./ui
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  xdg.portal.config = {
    common = {
      default = [
        "gtk"
      ];
    };
  };

  home = {
    username = "hayato";
    homeDirectory = "/home/hayato";
    sessionVariables = {
      EDITOR = "lvim";
    };
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}

{ pkgs, inputs, ... }:

{
  imports = [
    ./programs.nix
    ./overlays.nix
    ../../common/dell.nix
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  xdg.portal.config = {
    common = {
      default = [
        "gtk"
        "hyprland"
      ];
    };
  };

  home = {
    username = "hayato";
    homeDirectory = "/home/hayato";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}

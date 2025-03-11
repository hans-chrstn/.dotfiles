{ pkgs, inputs, ... }:

{
  imports = [
    ./overlays.nix
    ../../common/masato.nix
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
    username = "masato";
    homeDirectory = "/home/masato";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.11";
}

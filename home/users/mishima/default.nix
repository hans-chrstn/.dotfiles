{ pkgs, outputs, inputs, ... }:

{
  imports = [
    ./programs.nix
    ./overlays.nix
    ../../common/mishima.nix
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  programs.gaming.enable = true;
  programs.camera.enable = true;

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
    username = "mishima";
    homeDirectory = "/home/mishima";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.11";
}

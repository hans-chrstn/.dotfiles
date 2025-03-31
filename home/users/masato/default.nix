{ pkgs, inputs, outputs, ... }:

{
  imports = [
    ./overlays.nix
    ./programs.nix
    ../../common/masato.nix
  ] ++ (builtins.attrValues outputs.homeManagerModules);

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

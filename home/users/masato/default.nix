{ pkgs, inputs, outputs, ... }:

{
  imports = [
    ./overlays.nix
    ./programs.nix
    ../../common/masato.nix
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  mod = {
    btop.enable = true;
    dconf.enable = true;
    direnv.enable = true;
    git = {
      userName = "hayato-oo";
      userEmail = "xuhiko13@gmail.com";
    };
    kitty.enable = true;
    lazygit.enable = true;
  };

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

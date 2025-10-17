{ pkgs, inputs, outputs, ... }:

{
  imports = [
    ./programs.nix
    ./overlays.nix
    ../../common/hayato.nix
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  mod = {
    lazygit.enable = true;
    dconf.enable = true;
    btop.enable = true;
    kitty.enable = true;
    theme.enable = true;
    hyprland.enable = true;
    joplin.enable = true;
    nix-index.enable = true;
    zen.enable = true;
  };


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

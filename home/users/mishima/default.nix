{ pkgs, outputs, inputs, ... }:

{
  imports = [
    ./programs.nix
    ./overlays.nix
    ../../common/mishima.nix
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  mod = {
    gaming.enable = true;
    camera.enable = true;
    btop.enable = true;
    dconf = {
      enable = true;
      dark-scheme = true;
    };
    direnv.enable = true;
    git = {
      enable = true;
      userName = "hayato-oo";
      userEmail = "xuhiko13@gmail.com";
    };
    hyprland.enable = true;
    hyprpaper.enable = true;
    kitty.enable = true;
    lazygit.enable = true;
    minecraft.enable = true;
    mpv.enable = true;
    nix-index.enable = true;
    theme.enable = true;
    yt-dlp.enable = true;
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

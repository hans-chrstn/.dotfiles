{ pkgs, outputs, inputs, ... }:

{
  imports = [
    ./programs.nix
    ./overlays.nix
    ../../common/mishima.nix
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  mod = {
    android-studio.enable = true;
    camera.enable = true;
    btop = {
      enable = true;
      enableCustomSettings = true;
      enableCustomTheme = true;
    };
    dconf = {
      enable = true;
      dark-scheme = true;
    };
    direnv.enable = true;
    gaming.enable = true;
    git = {
      enable = true;
      userName = "hayato-oo";
      userEmail = "xuhiko13@gmail.com";
      enableGh = true;
    };
    hyprland.enable = true;
    hyprpaper.enable = true;
    joplin.enable = true;
    kitty.enable = true;
    lazygit.enable = true;
    minecraft.enable = true;
    mpv.enable = true;
    nix-index.enable = true;
    spicetify.enable = true;
    theme.enable = true;
    unity.enable = true;
    vscode.enable = true;
    yt-dlp.enable = true;
    zen.enable = true;
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

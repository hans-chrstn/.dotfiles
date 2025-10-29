{
  lib,
  inputs,
  modules,
  pkgs,
  ...
}: {
  imports = [
    modules.btop
    modules.camera
    modules.dconf
    modules.direnv
    modules.discord
    modules.gaming
    modules.git
    modules.lazygit
    modules.minecraft
    modules.monitors
    modules.neofetch
    # modules.niri
    modules.nix-index
    modules.obs
    modules.unity
    modules.vscode
    modules.yazi
    modules.zen
    modules.zsh
    inputs.dotstylix.homeModules.default
  ];

  monitors = {
    center = {
      name = "HDMI-A-3";
      width = 1920;
      height = 1080;
      refreshRate = 100.01;
      position = {
        x = 1080;
        y = 1080;
      };
      scale = 1.0;
    };

    left = {
      name = "HDMI-A-2";
      width = 1920;
      height = 1080;
      refreshRate = 74.973;
      position = {
        x = 0;
        y = 0;
      };
      transform = 270;
      scale = 1.0;
    };

    top = {
      name = "DP-5";
      width = 1920;
      height = 1080;
      refreshRate = 59.939;
      position = {
        x = 1080;
        y = 0;
      };
    };
  };

  theme = {
    enable = true;
    scheme = "desert-taupe-earth";
  };

  home = {
    username = "jin";
    homeDirectory = "/home/jin";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  mod.programs = {
    btop = {
      enable = true;
      enableCustomSettings = true;
    };
    camera.enable = true;
    dconf.enable = true;
    direnv.enable = true;
    discord = {
      enable = true;
      useVesktop = true;
    };
    gaming.enable = true;
    git = {
      enable = true;
      userName = "hayato-oo";
      userEmail = "xuhiko13@gmail.com";
    };
    lazygit.enable = true;
    # niri.enable = true;
    minecraft.enable = true;
    neofetch.enable = true;
    nix-index.enable = true;
    obs.enable = true;
    unity.enable = true;
    vscode.enable = true;
    yazi.enable = true;
    zen.enable = true;
    zsh.enable = true;
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    inputs.dotnixvim.packages."${pkgs.system}".default
  ];

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}

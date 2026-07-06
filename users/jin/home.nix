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
    modules.neovim
    modules.nix-index
    modules.nyxt
    modules.obs
    modules.unity
    modules.shell
    modules.vscode
    modules.widgets
    modules.yazi
    modules.zen
    modules.niri
    inputs.dotstylix.homeModules.default
  ];

  monitors = {
    center-top = {
      name = "DP-3";
      width = 1920;
      height = 1080;
      refreshRate = 99.650000;
      position = {
        x = 1080;
        y = 0;
      };
      scale = 1.0;
    };

    center = {
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      refreshRate = 120.000000;
      position = {
        x = 1080;
        y = 1080;
      };
      scale = 1.0;
    };

    center-left = {
      name = "DP-1";
      width = 1920;
      height = 1080;
      refreshRate = 74.973000;
      transform = 270;
      position = {
        x = 0;
        y = 0;
      };
      scale = 1.0;
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
    minecraft.enable = true;
    neovim.enable = true;
    neofetch.enable = true;
    niri.enable = true;
    nix-index.enable = true;
    nyxt.enable = true;
    obs.enable = true;
    unity.enable = true;
    vscode.enable = true;
    yazi.enable = true;
    zen.enable = true;
    shell = {
      enableZsh = false;
      enableNushell = true;
      enableFish = true;
      enableStarship = true;
    };
  };

  programs.brave.enable = true;
  programs.quickshell = {
    enable = true;
    systemd.enable = false;
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    flatpak
    ffmpeg
    gemini-cli
    libreoffice
    tradingview
    xfce.thunar
  ];

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}

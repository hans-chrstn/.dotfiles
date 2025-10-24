{
  inputs,
  modules,
  pkgs,
  ...
}: {
  imports = [
    modules.home-manager.btop
    modules.home-manager.camera
    modules.home-manager.dconf
    modules.home-manager.direnv
    modules.home-manager.discord
    modules.home-manager.gaming
    modules.home-manager.git
    modules.home-manager.lazygit
    modules.home-manager.mangowc
    modules.home-manager.minecraft
    modules.home-manager.monitors
    modules.home-manager.neofetch
    modules.home-manager.niri
    modules.home-manager.nix-index
    modules.home-manager.obs
    modules.home-manager.unity
    modules.home-manager.vscode
    modules.home-manager.wezterm
    modules.home-manager.yazi
    modules.home-manager.zen
    modules.home-manager.zsh
    inputs.dotstylix.homeModules.default
  ];

  monitors = {
    center = {
      name = "HDMI-A-3";
      width = 1920;
      height = 1080;
      refreshRate = 100.01;
      position = {
        x = 0;
        y = 0;
      };
      scale = 1.0;
    };

    left = {
      name = "HDMI-A-2";
      width = 1920;
      height = 1080;
      refreshRate = 74.973;
      position = {
        x = -1080;
        y = -1080;
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
        x = 0;
        y = -1080;
      };
    };
  };

  theme = {
    enable = true;
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
    discord.enable = true;
    gaming.enable = true;
    git = {
      enable = true;
      userName = "hayato-oo";
      userEmail = "xuhiko13@gmail.com";
    };
    lazygit.enable = true;
    mangowc.enable = true;
    minecraft.enable = true;
    neofetch.enable = true;
    niri.enable = true;
    nix-index.enable = true;
    obs.enable = true;
    unity.enable = true;
    vscode.enable = true;
    wezterm = {
      enable = true;
      window = {
        decorations = "RESIZE";
        adjustWindowSizeWhenChangingFontSize = false;
        boldBrightensAnsiColors = true;
        warnAboutMissingGlyphs = false;
      };
      tabBar = {
        enable = true;
        hideIfOnlyOneTab = true;
        atBottom = false;
        useFancy = true;
        showNewTabButton = true;
        showCloseTabButton = true;
        showTabIndex = false;
      };
      behavior = {
        quitWhenAllWindowsAreClosed = true;
        scrollbackLines = 3000;
        audibleBell = false;
        automaticallyReloadConfig = true;
        scrollToBottomOnInput = true;
        exitBehavior = "Close";
        hideMouseCursorWhenTyping = true;
        paneFocusFollowsMouse = true;
        checkForUpdates = false;
      };
      performance = {
        frontEnd = "OpenGL";
      };
    };
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

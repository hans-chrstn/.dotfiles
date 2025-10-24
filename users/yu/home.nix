{
  modules,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    modules.home-manager.btop
    modules.home-manager.dconf
    modules.home-manager.direnv
    modules.home-manager.discord
    modules.home-manager.git
    modules.home-manager.lazygit
    modules.home-manager.monitors
    modules.home-manager.neofetch
    modules.home-manager.niri
    modules.home-manager.vscode
    modules.home-manager.yazi
    modules.home-manager.wezterm
    modules.home-manager.zen
    modules.home-manager.zsh
    inputs.dotstylix.homeModules.default
  ];

  theme = {
    enable = true;
  };

  monitors = {
    main = {
      name = "eDP-1";
      width = 1366;
      height = 768;
      refreshRate = 59.999;
    };
  };

  home = {
    username = "yu";
    homeDirectory = "/home/yu";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  mod.programs = {
    btop = {
      enable = true;
      enableCustomSettings = true;
    };
    dconf.enable = true;
    direnv.enable = true;
    discord.enable = true;
    git = {
      enable = true;
      userName = "hayato-oo";
      userEmail = "xuhiko13@gmail.com";
    };
    lazygit.enable = true;
    neofetch.enable = true;
    niri.enable = true;
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
    moonlight-qt
    inputs.dotnixvim.packages."${pkgs.system}".default
  ];

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}

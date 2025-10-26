{modules, ...}: {
  imports = [
    modules.home-manager.wezterm
  ];
  mod.programs.wezterm = {
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
}

{lib, ...}: {
  options.mod.programs.mangowc.misc = {
    xwaylandPersistence = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable XWayland persistence (requires relogin)";
    };
    syncobjEnable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable drm_syncobj (requires relogin)";
    };
    adaptiveSync = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable variable refresh rate (VRR)";
    };
    exchangeCrossMonitor = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Allow exchanging windows across monitors";
    };
    scratchpadCrossMonitor = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "All monitors share the same scratchpad";
    };
    viewCurrentToBack = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Viewing current tag automatically returns to previous tag";
    };
    cursorHideTimeout = lib.mkOption {
      type = lib.types.int;
      default = 0;
      description = "Cursor hide timeout in seconds (0 = disable)";
    };
    singleScratchpad = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Only show one named scratchpad at a time";
    };
    sloppyFocus = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Focus follows mouse pointer";
    };
    warpCursor = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Warp cursor to focused window";
    };
    focusOnActivate = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Focus window when it sends activate event";
    };
    focusCrossMonitor = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Allow focus to move across monitors";
    };
    focusCrossTag = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Allow focus to move across tags";
    };
    enableFloatingSnap = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable snapping for floating windows";
    };
    snapDistance = lib.mkOption {
      type = lib.types.int;
      default = 30;
      description = "Maximum distance in pixels to trigger floating window snap";
    };
    noBorderWhenSingle = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Don't render border when window is alone in tag";
    };
    dragTileToTile = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Retile dragged tiled window when drag ends";
    };
    axisBindApplyTimeout = lib.mkOption {
      type = lib.types.int;
      default = 100;
      description = "Interval detection timeout for consecutive scrolls in milliseconds";
    };
    inhibitRegardlessOfVisibility = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Invisible windows can trigger idle inhibit";
    };
  };
}

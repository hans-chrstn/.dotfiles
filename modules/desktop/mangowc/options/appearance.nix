{lib, ...}: {
  options.mod.programs.mangowc.appearance = {
    gaps = {
      innerHorizontal = lib.mkOption {
        type = lib.types.int;
        default = 5;
        description = "Horizontal gap between windows";
      };
      innerVertical = lib.mkOption {
        type = lib.types.int;
        default = 5;
        description = "Vertical gap between windows";
      };
      outerHorizontal = lib.mkOption {
        type = lib.types.int;
        default = 10;
        description = "Horizontal gap from screen edges";
      };
      outerVertical = lib.mkOption {
        type = lib.types.int;
        default = 10;
        description = "Vertical gap from screen edges";
      };
    };
    borderpx = lib.mkOption {
      type = lib.types.int;
      default = 4;
      description = "Window border width in pixels";
    };
    scratchpad = {
      widthRatio = lib.mkOption {
        type = lib.types.float;
        default = 0.8;
        description = "Scratchpad width ratio (0.1-1.0)";
      };
      heightRatio = lib.mkOption {
        type = lib.types.float;
        default = 0.9;
        description = "Scratchpad height ratio (0.1-1.0)";
      };
    };
    colors = {
      root = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Root window background color in ARGB hex";
      };
      border = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Unfocused window border color in ARGB hex";
      };
      focus = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Focused window border color in ARGB hex";
      };
      urgent = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Urgent window border color in ARGB hex";
      };
      maximizescreen = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Maximized window border color in ARGB hex";
      };
      scratchpad = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Scratchpad window border color in ARGB hex";
      };
      global = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Global window border color in ARGB hex";
      };
      overlay = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Overlay window border color in ARGB hex";
      };
    };
  };
}

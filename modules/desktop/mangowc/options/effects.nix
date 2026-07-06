{lib, ...}: {
  options.mod.programs.mangowc.effects = {
    blur = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable window blur effect (impacts performance)";
    };
    blurLayer = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable blur for layers (popups, notifications, etc.)";
    };
    blurOptimized = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Cache wallpaper and blur background to reduce GPU usage";
    };
    blurPasses = lib.mkOption {
      type = lib.types.int;
      default = 2;
      description = "Number of blur passes for quality";
    };
    blurRadius = lib.mkOption {
      type = lib.types.int;
      default = 5;
      description = "Blur radius in pixels";
    };
    blurNoise = lib.mkOption {
      type = lib.types.float;
      default = 0.02;
      description = "Noise level added to blur";
    };
    blurBrightness = lib.mkOption {
      type = lib.types.float;
      default = 0.9;
      description = "Brightness adjustment for blur";
    };
    blurContrast = lib.mkOption {
      type = lib.types.float;
      default = 0.9;
      description = "Contrast adjustment for blur";
    };
    blurSaturation = lib.mkOption {
      type = lib.types.float;
      default = 1.2;
      description = "Saturation adjustment for blur";
    };
    shadows = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable window shadows";
    };
    shadowOnlyFloating = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Only draw shadows for floating windows";
    };
    layerShadows = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable shadows for layers";
    };
    shadowsSize = lib.mkOption {
      type = lib.types.int;
      default = 10;
      description = "Shadow size in pixels";
    };
    shadowsBlur = lib.mkOption {
      type = lib.types.int;
      default = 15;
      description = "Shadow blur amount";
    };
    shadowsPositionX = lib.mkOption {
      type = lib.types.int;
      default = 0;
      description = "Shadow horizontal offset";
    };
    shadowsPositionY = lib.mkOption {
      type = lib.types.int;
      default = 0;
      description = "Shadow vertical offset";
    };
    shadowsColor = lib.mkOption {
      type = lib.types.str;
      default = "000000ff";
      description = "Shadow color in ARGB hex format";
    };
    borderRadius = lib.mkOption {
      type = lib.types.int;
      default = 6;
      description = "Window border radius in pixels";
    };
    noRadiusWhenSingle = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Disable border radius when only one window is visible";
    };
    focusedOpacity = lib.mkOption {
      type = lib.types.float;
      default = 1.0;
      description = "Opacity of focused windows (0.0-1.0)";
    };
    unfocusedOpacity = lib.mkOption {
      type = lib.types.float;
      default = 1.0;
      description = "Opacity of unfocused windows (0.0-1.0)";
    };
  };
}

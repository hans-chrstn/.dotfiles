{lib, ...}: {
  options.mod.programs.mangowc.layout = {
    scroller = {
      structs = lib.mkOption {
        type = lib.types.int;
        default = 20;
        description = "Width reserved on both sides of screen when window ratio is 1.0";
      };
      defaultProportion = lib.mkOption {
        type = lib.types.float;
        default = 0.8;
        description = "Default proportion for scroller window width";
      };
      focusCenter = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Always center the focused window in scroller layout";
      };
      proportionPreset = lib.mkOption {
        type = with lib.types; listOf float;
        default = [0.5 0.8 1.0];
        description = "Preset proportions for cycling window sizes";
      };
      preferCenter = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Center focused window only if last focused window was outside monitor";
      };
      edgeScrollerPointerFocus = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Focus windows by pointer even if not completely in monitor";
      };
      defaultProportionSingle = lib.mkOption {
        type = lib.types.float;
        default = 1.0;
        description = "Default proportion when only single window in current tag";
      };
    };
    masterStack = {
      newIsMaster = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "New windows become master in master-stack layout";
      };
      defaultMfact = lib.mkOption {
        type = lib.types.float;
        default = 0.55;
        description = "Default master area factor (proportion of screen)";
      };
      defaultNmaster = lib.mkOption {
        type = lib.types.int;
        default = 1;
        description = "Default number of master windows";
      };
      smartGaps = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Remove gaps when only one window is visible";
      };
      centerMasterOverspread = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Center master window overspreads whole screen when no stack window (center_tile layout only)";
      };
      centerWhenSingleStack = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Center master window when only one stack window (center_tile layout only)";
      };
    };
  };
}

{lib, ...}: {
  options.mod.programs.mangowc.overview = {
    enableHotArea = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable hot corner for triggering overview mode";
    };
    hotAreaSize = lib.mkOption {
      type = lib.types.int;
      default = 10;
      description = "Hot area size in pixels (bottom left corner)";
    };
    tabMode = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Circle through windows in overview and exit on modifier release";
    };
    innerGap = lib.mkOption {
      type = lib.types.int;
      default = 5;
      description = "Inner gap between windows in overview mode";
    };
    outerGap = lib.mkOption {
      type = lib.types.int;
      default = 30;
      description = "Outer gap from screen edges in overview mode";
    };
  };
}

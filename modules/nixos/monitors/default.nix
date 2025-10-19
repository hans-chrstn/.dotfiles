{ lib, config, ... }:
{
  options.monitors = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        name = lib.mkOption {
          type = lib.types.str;
          description = "The hardware name of the monitor (e.g., HDMI-A-1)";
        };
        width = lib.mkOption { type = lib.types.int; };
        height = lib.mkOption { type = lib.types.int; };
        refreshRate = lib.mkOption { type = lib.types.float; };
        position = lib.mkOption {
          type = lib.types.attrsOf lib.types.int;
          default = { x = 0; y = 0; };
          description = "Position as { x = ...; y = ...; }";
        };
        transform = lib.mkOption {
          type = lib.types.nullOr (lib.types.enum [ 90 180 270 ]);
          default = null;
          description = "Rotation in degrees (e.g., 90, 180, 270)";
        };
        scale = {
          type = lib.types.float;
          default = 1.0;
          description = "The scaling factor for the monitor (e.g. 1.0, 1.5, 2.0).";
        };
      };
    });
    default = {};
    description = "Monitor layouts for this host.";
  };
}

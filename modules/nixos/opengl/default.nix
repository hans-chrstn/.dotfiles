{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.mod.hardware.opengl;
in {
  options.mod.hardware.opengl = {
    enable = lib.mkEnableOption "Enable the opengl feature";
    # enableXserver = lib.mkOption { type = lib.types.bool; default = true; };
  };

  config = lib.mkIf cfg.enable {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
        ];
        extraPackages32 = [
        ];
      };
    };
  };
}

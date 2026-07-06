{
  lib,
  config,
  ...
}: let
  cfg = config.mod.wm.hyprland;
in {
  options.mod.wm.hyprland = {
    enable = lib.mkEnableOption "Enable the hyprland feature";
    # enableXserver = lib.mkOption { type = lib.types.bool; default = true; };
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
    };

    # for example:
    # environment.systemPackages = [ pkgs.my-package ];
    # services.xserver.enable = cfg.enableXserver;
  };
}

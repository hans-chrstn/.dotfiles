{ pkgs, lib, config, ... }:
let
  cfg = config.mod.programs.dbus;
in
{
  options.mod.programs.dbus = {
    enable = lib.mkEnableOption "Enable the dbus";
  };

  config = lib.mkIf cfg.enable {
    programs.dconf.enable = true;

    services = {
      gvfs.enable = true;
      dbus = {
        packages = with pkgs; [dconf];
        enable = true;
        implementation = "dbus";
      };
    };

  };
}

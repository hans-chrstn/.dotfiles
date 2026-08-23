{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.dotfiles.system.dbus;
in {
  options.dotfiles.system.dbus = {
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

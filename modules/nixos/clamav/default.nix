{ pkgs, lib, config, ... }:
let
  cfg = config.mod.services.clamav;
in
{
  options.mod.services.clamav = {
    enable = lib.mkEnableOption "Enable the clamav feature";
    directories = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "/" ];
      description = "Lsit of directories that ClamAV will scan";
      example = [ "/home" "/mnt" ];
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      clamav
    ];
    services.clamav = {
      daemon.enable = true;
      updater.enable = true;
      scanner = {
        enable = true;
        scanDirectories = cfg.directories;
      };
    };
  };
}

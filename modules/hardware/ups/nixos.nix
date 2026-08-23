{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.dotfiles.hardware.ups;
in {
  options.dotfiles.hardware.ups = {
    enable = lib.mkEnableOption "Enable the ups feature";

    mode = lib.mkOption {
      type = lib.types.enum ["netclient" "standalone"];
      default = "netclient";
      description = "Set to netclient to monitor a remote UPS.";
    };

    ip = lib.mkOption {
      type = lib.types.str;
      default = "192.168.1.1";
      description = "The IP address of the NUT master.";
    };

    upsName = lib.mkOption {
      type = lib.types.str;
      default = "cyberpower";
      description = "The name of the UPS defined on the master.";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "monuser";
      description = "The NUT monitor user account.";
    };

    passwordFile = lib.mkOption {
      type = lib.types.path;
      description = "Path to the sops-nix secret containing the monitor password.";
    };
  };

  config = lib.mkIf cfg.enable {
    power.ups = {
      enable = true;
      mode = cfg.mode;

      upsmon.monitor."${cfg.upsName}@${cfg.ip}" = {
        user = cfg.user;
        passwordFile = cfg.passwordFile;
        type = "slave";
      };

      upsmon.settings = {
        SHUTDOWNCMD = "${pkgs.systemd}/bin/systemctl poweroff";
      };
    };
  };
}

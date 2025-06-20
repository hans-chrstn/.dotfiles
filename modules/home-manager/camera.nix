{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.camera;
in
{
  options.mod.camera = {
    enable = mkEnableOption "Enable Emeet camera config and it's best values";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      v4l-utils
    ];

    systemd.user.services.v4l2-settings = {
      Unit = {
        Description = "Configure V4L2 Camera Settings";
      };
      Service = {
        ExecStart = pkgs.writeShellScript "v4l2-setup" ''
          sleep 2
          ${pkgs.v4l-utils}/bin/v4l2-ctl -d /dev/video0 --set-ctrl=saturation=80
          ${pkgs.v4l-utils}/bin/v4l2-ctl -d /dev/video0 --set-ctrl=zoom_absolute=45
          ${pkgs.v4l-utils}/bin/v4l2-ctl -d /dev/video0 --set-ctrl=brightness=-64
          ${pkgs.v4l-utils}/bin/v4l2-ctl -d /dev/video0 --set-ctrl=hue=20
          ${pkgs.v4l-utils}/bin/v4l2-ctl -d /dev/video0 --set-ctrl=sharpness=10
          ${pkgs.v4l-utils}/bin/v4l2-ctl -d /dev/video0 --set-ctrl=contrast=18
        '';
        Restart = "no";
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}


{ lib, config, ... }:
with lib;
let
 cfg = config.mod.hypridle;
in
{
  options.mod.hypridle = {
    enable = mkEnableOption "Enable hypridle config and it's best values";
  };

  config = mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          ignore_dbus_inhibit = false;
        };

        listener = [
          {
            timeout = 900;
            on-timeout = "hyprlock";
            on-resume = "notify-send '󱜚   Welcome back, $USER'";
          }
        ];

      };
    };
  };
}

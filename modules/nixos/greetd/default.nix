{ pkgs, lib, config, ... }:
let
  cfg = config.mod.services.greetd;
in
{
  options.mod.services.greetd = {
    enable = lib.mkEnableOption "Enable the greetd feature";
  };

  config = lib.mkIf cfg.enable {
    services.greetd =  {
      enable = true;
      settings = {
        terminal.vt = 1;
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session";
          user = "greeter";
        };
      };
    };

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };

    security.pam.services.greetd.enableGnomeKeyring = true;
  };
}

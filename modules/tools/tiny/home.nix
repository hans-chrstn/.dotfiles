{
  lib,
  config,
  ...
}: let
  cfg = config.dotfiles.programs.tiny;
in {
  options.dotfiles.programs.tiny = {
    enable = lib.mkEnableOption "Enable the tiny IRC client";
  };

  config = lib.mkIf cfg.enable {
    programs.tiny = {
      enable = true;
      settings = {
        servers = [
          {
            addr = "irc.rizon.net";
            port = 6697;
            tls = true;
            realname = "yamatooti";
            nicks = ["yamatooti"];
            join = [
              "#avistaz"
              "#cinemaz"
              "#exoticaz"
              "#AnimeZ"
            ];
          }
        ];
        defaults = {
          nicks = ["jin"];
          realname = "jin";
          join = [];
          tls = true;
        };
        log_dir = "${config.home.homeDirectory}/.local/share/tiny_logs";
      };
    };
  };
}

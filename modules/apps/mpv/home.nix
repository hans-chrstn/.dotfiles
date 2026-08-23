{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.dotfiles.programs.mpv;
in {
  options.dotfiles.programs.mpv = {
    enable = lib.mkEnableOption "Enable mpv config and its best values";
  };

  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      package = pkgs.mpv.override {
        scripts = with pkgs.mpvScripts; [
          uosc
          sponsorblock
          mpris
        ];
      };
      config = {
        profile = "high-quality";
        ytdl-format = "bestvideo+bestaudio";
      };
    };
  };
}

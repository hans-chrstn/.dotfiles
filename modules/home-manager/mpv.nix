{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.mpv;
in
{
  options.mod.mpv = {
    enable = mkEnableOption "Enable mpv config and it's best values";
  };

  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      package = (
        pkgs.mpv-unwrapped.wrapper {
          scripts = with pkgs.mpvScripts; [
            uosc
            sponsorblock
            mpris
          ];

          mpv = pkgs.mpv-unwrapped.override {
            waylandSupport = true;
          };
        }
      );
      config = {
        profile = "high-quality";
        ytdl-format = "bestvideo+bestaudio";
      };
    };
  };
}

{ lib, pkgs, config, ... }:
let
 cfg = config.mod.programs.mpv;
in
{
  options.mod.programs.mpv = {
    enable = lib.mkEnableOption "Enable mpv config and it's best values";
  };

  config = lib.mkIf cfg.enable {
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

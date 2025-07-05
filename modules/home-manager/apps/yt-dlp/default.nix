{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.yt-dlp;
in
{
  options.mod.yt-dlp = {
    enable = mkEnableOption "Enable yt-dlp";
  };

  config = mkIf cfg.enable {
    programs.yt-dlp = {
      enable = true;
    };
  };
}

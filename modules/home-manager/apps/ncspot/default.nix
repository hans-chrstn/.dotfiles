{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.ncspot;
in
{
  options.mod.ncspot = {
    enable = mkEnableOption "Enable ncspot";
  };

  config = mkIf cfg.enable {
    programs.ncspot = {
      enable = true;
      settings = {
        shuffle = true;
        notify = true;
        repeat = "playlist";
        use_nerdfont = true;
        flip_status_indicators = true;
        gapless = true;
      };
    };
  };
}

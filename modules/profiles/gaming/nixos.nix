{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.mod.profiles.gaming;
in {
  options.mod.profiles.gaming = {
    enable = lib.mkEnableOption "Gaming Profile";
  };

  config = lib.mkIf cfg.enable {
    mod.programs.steam.enable = true;
    mod.services.sunshine.enable = true;

    # Improve gaming performance for wine/proton
    boot.ntsync.enable = true;
  };
}

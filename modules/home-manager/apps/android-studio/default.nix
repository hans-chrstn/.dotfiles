{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.android-studio;
in
{
  options.mod.android-studio = {
    enable = mkEnableOption "Enable Android Studio";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      android-studio
    ];
  };
}

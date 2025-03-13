{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.programs.gaming;
in 
{
  options.programs.gaming = {
    enable = mkEnableOption "Enable gaming";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (lutris.override {
        extraPkgs = pkgs: [
          jansson
          winetricks
          (wineWowPackages.full.override {
            wineRelease = "staging";
            mingwSupport = true;
          })
        ];
      })
      bottles
      protonup-qt
      protontricks
      cartridges
      heroic
      gogdl
      sunshine
      winetricks
      (wineWowPackages.full.override {
        wineRelease = "staging";
        mingwSupport = true;
      })
    ];
  };
}

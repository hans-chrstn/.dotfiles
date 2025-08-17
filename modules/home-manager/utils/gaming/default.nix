{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.gaming;
in 
{
  options.mod.gaming = {
    enable = mkEnableOption "Enable gaming";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      limo
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
      cartridges
      heroic
      gogdl
      # winetricks
      # (wineWowPackages.full.override {
      #   wineRelease = "staging";
      #   mingwSupport = true;
      # })
    ];
  };
}

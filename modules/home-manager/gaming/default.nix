{ lib, pkgs, config, ... }:
let
 cfg = config.mod.programs.gaming;
in 
{
  options.mod.programs.gaming = {
    enable = lib.mkEnableOption "Enable gaming";
  };

  config = lib.mkIf cfg.enable {
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
    ];
  };
}

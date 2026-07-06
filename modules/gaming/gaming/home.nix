{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.mod.programs.gaming;
in {
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
          wineWow64Packages.waylandFull
        ];
      })
      cabextract
      bottles
      cartridges
      heroic
      gogdl
    ];
  };
}

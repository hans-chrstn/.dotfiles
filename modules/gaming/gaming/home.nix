{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.dotfiles.gaming.packages;
in {
  options.dotfiles.gaming.packages = {
    enable = lib.mkEnableOption "Enable gaming";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      limo
      (lutris.override {
        extraPkgs = _pkgs: [
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

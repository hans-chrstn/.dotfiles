{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.mod.wm.niri;
in {
  imports = [
    inputs.niri.nixosModules.niri
  ];

  options.mod.wm.niri = {
    enable = lib.mkEnableOption "Enable Niri Window Manager";
    channel = lib.mkOption {
      type = lib.types.enum ["stable" "unstable"];
      default = "stable";
      description = ''
        Selects which Niri package to use:
        - "stable" uses the stable release.
        - "unstable" uses the bleeding-edge build.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    programs.niri = {
      enable = true;
      package = (if cfg.channel == "stable"
        then pkgs.niri-stable
        else pkgs.niri-unstable
      );
    };
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  };
}

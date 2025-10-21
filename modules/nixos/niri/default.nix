{
  pkgs,
  inputs,
  lib,
  config,
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
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      config.common.default = ["gtk"];
    };

    programs.niri = {
      enable = true;
      package = (
        if cfg.channel == "stable"
        then pkgs.niri-stable
        else pkgs.niri-unstable
      );
    };
    environment.systemPackages = with pkgs; [xwayland-satellite];
    nixpkgs.overlays = [inputs.niri.overlays.niri];
  };
}

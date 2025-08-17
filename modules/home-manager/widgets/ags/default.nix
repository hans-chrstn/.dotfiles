{ lib, config, inputs, pkgs, ... }:
with lib;
let
  cfg = config.mod.ags;
in
{
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  options.mod.ags = {
    enable = mkEnableOption "Enable AGS config with extra packages.";
  };

  config = mkIf cfg.enable (mkMerge
    [
      {
        programs.ags.enable = true;
        programs.ags.extraPackages = with pkgs; [
          gtksourceview
          accountsservice
          sassc
          bun
          libcava
          gvfs
          gobject-introspection
          inputs.astal.packages.${pkgs.system}.default
          inputs.astal.packages.${pkgs.system}.io
          inputs.astal.packages.${pkgs.system}.astal3
          inputs.astal.packages.${pkgs.system}.apps
          inputs.astal.packages.${pkgs.system}.auth
          inputs.astal.packages.${pkgs.system}.battery
          inputs.astal.packages.${pkgs.system}.bluetooth
          inputs.astal.packages.${pkgs.system}.cava
          inputs.astal.packages.${pkgs.system}.greet
          inputs.astal.packages.${pkgs.system}.hyprland
          inputs.astal.packages.${pkgs.system}.mpris
          inputs.astal.packages.${pkgs.system}.network
          inputs.astal.packages.${pkgs.system}.notifd
          inputs.astal.packages.${pkgs.system}.powerprofiles
          inputs.astal.packages.${pkgs.system}.tray
          inputs.astal.packages.${pkgs.system}.wireplumber

        ];
        programs.ags.configDir = ./config;
        home.packages = [
          inputs.astal.packages.${pkgs.system}.default
          inputs.astal.packages.${pkgs.system}.io
          inputs.astal.packages.${pkgs.system}.astal3
          inputs.astal.packages.${pkgs.system}.apps
          inputs.astal.packages.${pkgs.system}.auth
          inputs.astal.packages.${pkgs.system}.battery
          inputs.astal.packages.${pkgs.system}.bluetooth
          inputs.astal.packages.${pkgs.system}.cava
          inputs.astal.packages.${pkgs.system}.greet
          inputs.astal.packages.${pkgs.system}.hyprland
          inputs.astal.packages.${pkgs.system}.mpris
          inputs.astal.packages.${pkgs.system}.network
          inputs.astal.packages.${pkgs.system}.notifd
          inputs.astal.packages.${pkgs.system}.powerprofiles
          inputs.astal.packages.${pkgs.system}.tray
          inputs.astal.packages.${pkgs.system}.wireplumber
        ];
      }
    ]
  );
}

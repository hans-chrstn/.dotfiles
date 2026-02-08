{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.mod.programs.widgets;
in {
  imports = [
    inputs.ink.homeModules.default
  ];
  options.mod.programs.widgets = {
    enableInk = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Ink Layer Shell Widgets";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enableInk {
      programs.ink.enable = true;
      services.playerctld.enable = true;
      home.packages = with pkgs; [libnotify];
    })
  ];
}

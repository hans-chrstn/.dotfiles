{ lib, pkgs, config, ... }:
let
  cfg = config.mod.programs.godot;
in
{
  options.mod.programs.godot = {
    enable = lib.mkEnableOption "Enable the godot feature";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      godot-mono
      aseprite
      dotnet-sdk_9
    ];
  };
}

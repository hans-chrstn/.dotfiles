{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.mod.godot;
in {
  options.mod.godot = {
    enable = lib.mkEnableOption "Enables godot";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      godot-mono
      aseprite
      dotnet-sdk_9
    ];
  };
}

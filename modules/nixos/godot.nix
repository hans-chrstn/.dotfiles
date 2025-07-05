{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.homelab.godot;
in {
  options = {
    homelab.godot.enable = lib.mkEnableOption "Enables godot";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      godot-mono
      aseprite
      dotnet-sdk_9
    ];
  };
}

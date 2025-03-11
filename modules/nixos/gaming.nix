{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.programs.virtualise; 
in 
{
  options.programs.gaming = {
    enable = mkEnableOption "Enable gaming";
  };

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-run"
    ];  
    environment.systemPackages = with pkgs; [
      ppsspp-sdl-wayland
      pcsx2
      cartridges
      prismlauncher
    ];
    programs = {
      gamemode = {
        enable = true;
      };
      steam = {
        gamescopeSession = {
          enable = true;
        };
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
      };
    };
  };
}

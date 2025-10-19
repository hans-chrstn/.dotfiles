{ pkgs, lib, config, ... }:
let
  cfg = config.mod.programs.steam;
in
{
  options.mod.programs.steam = {
    enable = lib.mkEnableOption "Enable the steam feature";
  };

  config = lib.mkIf cfg.enable {
    programs.gamemode.enable = true;

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-run"
    ];

    environment.systemPackages = with pkgs; [
      yad
      wineWowPackages.waylandFull
      winetricks
    ];

    boot.kernel.sysctl = {
      # SteamOS/Fedora default, can help with performance.
      "vm.max_map_count" = 2147483642;

      # Not part of my threat model and I'd rather not have performance tank in
      # poorly coded games.
      "kernel.split_lock_mitigate" = 0;
    };

    hardware.steam-hardware.enable = true;

    # STEAM
    programs.steam = {
      package = pkgs.steam-small.override {
        extraEnv = {
          MANGOHUD = true;
          #OBS_VK_CAPTURE = true;
          #PULSE_SINK = "game_sink";
          #RADV_TEX_ANISO = 16;
          DXVK_HUD = "compiler";
        };
        extraLibraries = p: with p; [
          atk
          dbus
          udev
        ];
      };
      enable = true;
      gamescopeSession = {
        enable = true;
      };
      protontricks.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        steamtinkerlaunch
      ];
    };
  };
}

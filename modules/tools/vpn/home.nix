{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.dotfiles.networking.vpn;
in {
  options.dotfiles.networking.vpn = {
    enableWireguard = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Wireguard and Tools";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enableWireguard {
      home.packages = with pkgs; [
        wireguard-tools
      ];
    })
  ];
}

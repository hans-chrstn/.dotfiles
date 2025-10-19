{ pkgs, lib, config, ... }:
let
  cfg = config.mod.programs.via;
in
{
  options.mod.programs.via = {
    enable = lib.mkEnableOption "Enable the VIA";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      via
    ];

    services.udev.packages = with pkgs; [ via ];
  };
}

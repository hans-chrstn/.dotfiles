{ pkgs, lib, config, ... }:
let
  cfg = config.mod.services.sunshine;
in
{
  options.mod.services.sunshine = {
    enable = lib.mkEnableOption "Enable the sunshine feature";
    enableCuda = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable cuda support for sunshine";
    };
  };

  config = lib.mkIf cfg.enable {
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
      package = pkgs.sunshine.override { cudaSupport = cfg.enableCuda; };
    };
  };
}

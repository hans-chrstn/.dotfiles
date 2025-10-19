{ pkgs, lib, config, ... }:
let
  cfg = config.mod.hardware.bluetooth;
in
{
  options.mod.hardware.bluetooth = {
    enable = lib.mkEnableOption "Enable the bluetooth feature";
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          ControllerMode = "dual";
          FastConnectable = true;
          Experimental = true;
        };
      };
    };
    services.blueman.enable = true;
  };
}

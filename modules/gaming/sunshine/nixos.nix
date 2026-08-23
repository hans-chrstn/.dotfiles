{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.dotfiles.services.sunshine;
in {
  options.dotfiles.services.sunshine = {
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
      capSysAdmin = false;
      openFirewall = true;
      package = pkgs.sunshine.override {cudaSupport = cfg.enableCuda;};
      settings = {
        capture = "wlr";
      };
    };
  };
}

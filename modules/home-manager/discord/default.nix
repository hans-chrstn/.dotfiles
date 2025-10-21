{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.mod.programs.discord;
in {
  options.mod.programs.discord = {
    enable = lib.mkEnableOption "Enable the discord feature";
    # enableXserver = lib.mkOption { type = lib.types.bool; default = true; };
  };

  config = lib.mkIf cfg.enable {
    # for example:
    # environment.systemPackages = [ pkgs.my-package ];
    # services.xserver.enable = cfg.enableXserver;
    # for example:
    # environment.systemPackages = [ pkgs.my-package ];
    # services.xserver.enable = cfg.enableXserver;
    home.packages = with pkgs; [
      (discord.override {
        # withOpenASAR = true;
        withVencord = true;
      })
      discord-rpc
    ];
  };
}

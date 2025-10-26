{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.mod.programs.discord;
in {
  options.mod.programs.discord = {
    enable = lib.mkEnableOption "Enable Discord";
    useVesktop = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Use Vesktop instead of official Discord client";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (
        if cfg.useVesktop
        then vesktop
        else (discord.override {withVencord = true;})
      )

      discord-rpc
    ];

    xdg.desktopEntries = lib.mkIf cfg.useVesktop {
      vesktop = {
        name = "Vesktop";
        genericName = "Discord with Vencord";
        exec = "vesktop %U";
        icon = "discord";
        type = "Application";
        categories = ["Network" "InstantMessaging"];
      };
    };
  };
}

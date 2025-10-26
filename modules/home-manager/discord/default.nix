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
    programs.vesktop = lib.mkIf cfg.useVesktop {
      enable = true;
      vencord.settings = {
        appBadge = true;
        arRPC = true;
        checkUpdates = false;
        customTitleBar = false;
        disableMinSize = true;
        minimizeToTray = false;
        tray = false;
        hardwareAcceleration = true;
        discordBranch = "canary";
        plugins = {
          MessageLogger = {
            enabled = true;
            ignoreSelf = true;
          };
          FakeNitro.enabled = true;
          AnonymiseFileNames.enabled = true;
          BetterSessions.enabled = true;
          BetterSettings.enabled = true;
          CallTimer.enabled = true;
          ClearURLs.enabled = true;
          CustomRPC.enabled = true;
          CustomIdle.enabled = true;
          DisableCallIdle.enabled = true;
          FavoriteEmojiFirst.enabled = true;
          FixImagesQuality.enabled = true;
          FixYoutubeEmbeds.enabled = true;
          FriendsSince.enabled = true;
          GameActivityToggle.enabled = true;
          GifPaste.enabled = true;
          ImageZoom.enabled = true;
          KeepCurrentChannel.enabled = true;
          LastFMRichPresence.enabled = true;
          MessageLatency.enabled = true;
          ReadAllNotificationsButton.enabled = true;
          YoutubeAdblock.enabled = true;
          VolumeBooster.enabled = true;
          Unindent.enabled = true;
        };
      };
    };

    home.packages = with pkgs;
      lib.optionals cfg.useVesktop [
        (writeShellScriptBin "discord" ''
          exec vesktop "$@"
        '')
      ]
      ++ (lib.optionals (!cfg.useVesktop) [
        (discord.override {withVencord = true;})
      ]);

    xdg.desktopEntries.discord = lib.mkIf cfg.useVesktop {
      name = "Discord";
      exec = "vesktop %U";
      icon = "discord";
      type = "Application";
      categories = ["Network" "InstantMessaging"];
    };
  };
}

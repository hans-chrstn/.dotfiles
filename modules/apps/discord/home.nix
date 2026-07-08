{
  mkModule,
  lib,
  ...
} @ args:
mkModule {
  inherit args;
  name = "discord";
  extraOptions = {
    useVesktop = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Use Vesktop instead of official Discord client";
    };
  };
  configFunc = {...}: cfg: {
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
        hardwareAcceleration = false;
        discordBranch = "stable";
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
          NotTypingAnimation.enable = true;
          SilentTyping.enable = true;
        };
      };
    };

    programs.discord = lib.mkIf (!cfg.useVesktop) {
      enable = true;
      settings = {
        SKIP_HOST_UPDATE = true;
      };
    };
  };
}

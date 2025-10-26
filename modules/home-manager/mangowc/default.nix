{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.mod.programs.mangowc;
  formatters = import ./lib/formatters.nix {inherit lib;};
in {
  imports = [
    inputs.mango.hmModules.mango
    ./options/animations.nix
    ./options/appearance.nix
    ./options/bindings.nix
    ./options/effects.nix
    ./options/input.nix
    ./options/layout.nix
    ./options/misc.nix
    ./options/overview.nix
  ];

  options.mod.programs.mangowc = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Mango window compositor";
    };

    environment = lib.mkOption {
      type = with lib.types; attrsOf str;
      default = {
        XDG_CURRENT_DESKTOP = "wlroots";
        QT_QPA_PLATFORM = "wayland";
        XDG_SESSION_TYPE = "wayland";
        GDK_BACKEND = "wayland";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";
        MOZ_ENABLE_WAYLAND = "1";
        _JAVA_AWT_WM_NONREPARENTING = "1";
        GTK_USE_PORTAL = "1";
        NIXOS_XDG_OPEN_USE_PORTAL = "1";
        ANKI_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        QT_QPA_PLATFORMTHEME = "qt5ct";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      };
      description = "Environment variables to set (reset on config reload)";
    };

    exec = lib.mkOption {
      type = with lib.types; listOf str;
      default = [];
      description = "Commands to execute on every config reload";
    };

    execOnce = lib.mkOption {
      type = with lib.types; listOf str;
      default = [
        "systemctl --user import-environment XDG_CURRENT_DESKTOP WAYLAND_DISPLAY XDG_SESSION_TYPE"
        "dbus-update-activation-environment --systemd XDG_CURRENT_DESKTOP WAYLAND_DISPLAY XDG_SESSION_TYPE"
        "systemctl --user start xdg-desktop-portal-wlr.service"
        "sleep 1 && systemctl --user restart xdg-desktop-portal.service"
      ];
      description = "Commands to execute only once on Mango startup";
    };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra configuration lines to append to the config file";
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-wlr
      ];
      config = {
        common = {
          default = ["wlr" "gtk"];
        };
        wlroots = {
          default = ["wlr" "gtk"];
          "org.freedesktop.impl.portal.FileChooser.OpenFile" = "gtk";
          "org.freedesktop.impl.portal.FileChooser.SaveFile" = "gtk";
          "org.freedesktop.impl.portal.FileChooser.SaveFiles" = "gtk";
          "org.freedesktop.impl.portal.Screenshot" = "wlr";
          "org.freedesktop.impl.portal.ScreenCast" = "wlr";
          "org.freedesktop.impl.portal.RemoteDesktop" = "wlr";
        };
      };
    };

    home.sessionVariables = {
    };
    home.packages = with pkgs; [wlr-randr];
    wayland.windowManager.mango = {
      enable = true;
      settings = ''
        # More option see https://github.com/DreamMaoMao/mango/wiki/

        # Window effect
        ${formatters.generateEffectsConfig cfg.effects}

        # Animation Configuration(support type:zoom,slide)
        # tag_animation_direction: 0-horizontal,1-vertical
        ${formatters.generateAnimationsConfig cfg.animations}

        # Scroller Layout Setting
        ${formatters.generateScrollerConfig cfg.layout.scroller}

        # Master-Stack Layout Setting
        ${formatters.generateMasterStackConfig cfg.layout.masterStack}

        # Overview Setting
        ${formatters.generateOverviewConfig cfg.overview}

        # Misc
        ${formatters.generateMiscConfig cfg.misc cfg.input.cursor.size}

        # keyboard
        ${formatters.generateKeyboardConfig cfg.input.keyboard}

        # Trackpad
        # need relogin to make it apply
        ${formatters.generateTrackpadConfig cfg.input.trackpad}

        # mouse
        # need relogin to make it apply
        ${formatters.generateMouseConfig cfg.input.mouse cfg.input.cursor.theme}

        # Appearance
        ${formatters.generateAppearanceConfig cfg.appearance}

        # Monitors
        ${formatters.formatMonitors config.monitors}

        # Rules and Bindings
        ${formatters.formatTagRules cfg.tagRules}
        ${formatters.formatWindowRules cfg.windowRules}
        ${formatters.formatBinds cfg.bindings}
        ${formatters.formatLayerRules cfg.layerRules}
        ${formatters.formatMouseBinds cfg.mouseBindings}
        ${formatters.formatAxisBinds cfg.axisBindings}
        ${formatters.formatSwitchBinds cfg.switchBindings}
        ${formatters.formatGestureBinds cfg.gestureBindings}

        # Environment and Execution
        ${formatters.formatEnvs cfg.environment}
        ${lib.concatMapStringsSep "\n" (exec: "exec-once=${exec}") cfg.execOnce}
        ${lib.concatMapStringsSep "\n" (exec: "exec=${exec}") cfg.exec}

        # User's Extra Raw Config
        ${cfg.extraConfig}
      '';
    };
  };
}

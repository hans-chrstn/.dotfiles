{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.mod.programs.niri;

  formatMonitor = monitor: {
    enable = true;
    transform = lib.optionalAttrs (monitor.transform != null) {
      rotation = monitor.transform;
    };
    scale = monitor.scale;
    position = monitor.position;
    mode = {
      width = monitor.width;
      height = monitor.height;
      refresh = monitor.refreshRate;
    };
  };
in {
  options.mod.programs.niri = {
    enable = lib.mkEnableOption "Enable the niri feature";
  };

  config = lib.mkIf cfg.enable {
    # Enable global desktop abstractions automatically when Niri is enabled
    mod.desktop.wayland.enable = true;
    mod.desktop.keybinds.enable = true;

    home.packages = with pkgs; [xwayland-satellite];

    programs.niri.settings = {
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
      cursor.hide-when-typing = true;
      clipboard.disable-primary = true;
      hotkey-overlay.skip-at-startup = true;
      animations = {
        enable = true;
        workspace-switch.enable = true;
        workspace-switch.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 1000;
          epsilon = 0.0001;
        };
        window-open.enable = true;
        window-open.kind.easing = {
          duration-ms = 150;
          curve = "ease-out-expo";
          curve-args = [];
        };
        window-close.enable = true;
        window-close.kind.easing = {
          duration-ms = 150;
          curve = "ease-out-quad";
          curve-args = [];
        };
        horizontal-view-movement.enable = true;
        horizontal-view-movement.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 800;
          epsilon = 0.0001;
        };
        window-movement.enable = true;
        window-movement.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 800;
          epsilon = 0.0001;
        };
        window-resize.enable = true;
        window-resize.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 800;
          epsilon = 0.0001;
        };
        config-notification-open-close.enable = true;
        config-notification-open-close.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 800;
          epsilon = 0.0001;
        };
        exit-confirmation-open-close.enable = true;
        exit-confirmation-open-close.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 800;
          epsilon = 0.0001;
        };
        screenshot-ui-open.enable = true;
        screenshot-ui-open.kind.easing = {
          duration-ms = 150;
          curve = "ease-out-quad";
          curve-args = [];
        };
        overview-open-close.enable = true;
        overview-open-close.kind.spring = {
          damping-ratio = 1.0;
          stiffness = 800;
          epsilon = 0.0001;
        };
      };

      input = {
        mod-key = "Super";
        focus-follows-mouse.enable = true;
      };

      window-rules = [
        {
          geometry-corner-radius = {
            bottom-left = 15.0;
            bottom-right = 15.0;
            top-left = 15.0;
            top-right = 15.0;
          };
          clip-to-geometry = true;
        }
        {
          matches = [{title = "Extension: (Bitwarden Password Manager) - Bitwarden — Zen Twilight";}];
          open-floating = true;
          default-window-height.proportion = 0.2;
          default-column-width.proportion = 0.2;
          block-out-from = "screen-capture";
        }
        {
          matches = [
            {
              app-id = "firefox$";
              title = "^Picture-in-Picture$";
            }
          ];
          open-floating = true;
        }
      ];

      layout = {
        border.enable = false;
        focus-ring.enable = false;
        always-center-single-column = true;
        tab-indicator.hide-when-single-tab = true;
      };

      gestures = {hot-corners.enable = false;};

      # Map Global Keybinds to Niri API
      binds = with config.lib.niri.actions; let
        kb = config.mod.desktop.keybinds;
        mapMod = key: builtins.replaceStrings ["Mod"] [kb.modifier] key;

        mapAction = act: arg:
          if act == "spawn"
          then
            spawn [
              "sh"
              "-c"
              (
                if arg == "terminal"
                then kb.terminal
                else arg
              )
            ]
          else if act == "close"
          then close-window
          else if act == "toggle_float"
          then spawn ["sh" "-c" "niri msg action toggle-window-floating && niri msg action center-window && niri msg action focus-floating"]
          else if act == "maximize"
          then maximize-column
          else if act == "quit"
          then quit {skip-confirmation = true;}
          else if act == "toggle_overview"
          then toggle-overview
          else if act == "fullscreen"
          then spawn ["sh" "-c" "niri msg action fullscreen-window"]
          else if act == "focus_up"
          then focus-window-up-or-bottom
          else if act == "focus_down"
          then focus-window-down-or-top
          else if act == "focus_left"
          then focus-column-or-monitor-left
          else if act == "focus_right"
          then focus-column-or-monitor-right
          else if act == "focus_monitor_up"
          then focus-monitor-up
          else if act == "focus_monitor_down"
          then focus-monitor-down
          else if act == "focus_monitor_left"
          then focus-monitor-left
          else if act == "focus_monitor_right"
          then focus-monitor-right
          else if act == "move_up"
          then move-column-to-monitor-up
          else if act == "move_down"
          then move-column-to-monitor-down
          else if act == "move_left"
          then move-column-left-or-to-monitor-left
          else if act == "move_right"
          then move-column-right-or-to-monitor-right
          else if act == "consume_left"
          then consume-or-expel-window-left
          else if act == "consume_right"
          then consume-or-expel-window-right
          else if act == "move_up_workspace"
          then move-window-up-or-to-workspace-up
          else if act == "move_down_workspace"
          then move-window-down-or-to-workspace-down
          else if act == "resize_width_down"
          then spawn ["sh" "-c" "niri msg action set-column-width -5%"]
          else if act == "resize_width_up"
          then spawn ["sh" "-c" "niri msg action set-column-width +5%"]
          else if act == "workspace_up"
          then focus-workspace-up
          else if act == "workspace_down"
          then focus-workspace-down
          else if act == "screenshot"
          then spawn ["sh" "-c" "niri msg action screenshot"]
          else if act == "screenshot_screen"
          then spawn ["sh" "-c" "niri msg action screenshot-screen"]
          else if act == "screenshot_window"
          then spawn ["sh" "-c" "niri msg action screenshot-window"]
          else if act == "volume_up"
          then spawn ["sh" "-c" "wpctl set-volume @DEFAULT_SINK@ 5%+"]
          else if act == "volume_down"
          then spawn ["sh" "-c" "wpctl set-volume @DEFAULT_SINK@ 5%-"]
          else if act == "toggle_tabbed"
          then toggle-column-tabbed-display
          else null;

        actionBinds = lib.mapAttrs' (key: val: lib.nameValuePair (mapMod key) {action = mapAction val.action val.arg;}) kb.actions;
        # Filter out unmapped actions
        validBinds = lib.filterAttrs (n: v: v.action != null) actionBinds;

        workspaceBinds =
          if kb.workspaces.enable
          then
            builtins.foldl' (acc: x: acc // x) {} (
              builtins.genList (i: let
                ws = toString (i + 1);
              in {
                "${kb.modifier}+${ws}".action = focus-workspace (i + 1);
                "${kb.modifier}+Shift+${ws}".action = spawn ["sh" "-c" "niri msg action move-window-to-workspace ${ws}"];
              })
              kb.workspaces.count
            )
          else {};
      in
        validBinds // workspaceBinds;

      outputs =
        lib.mapAttrs' (name: monitor: {
          name = monitor.name;
          value = formatMonitor monitor;
        })
        config.monitors;
    };
  };
}

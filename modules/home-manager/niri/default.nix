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
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
      ];
      config = {
        common = {
          default = ["gtk"];
          "org.freedesktop.impl.portal.FileChooser.OpenFile" = "gtk";
          "org.freedesktop.impl.portal.FileChooser.SaveFile" = "gtk";
          "org.freedesktop.impl.portal.FileChooser.SaveFiles" = "gtk";
          "org.freedesktop.impl.portal.ScreenCast" = "gnome";
          "org.freedesktop.impl.portal.Screenshot" = "gnome";
          "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
        };
      };
    };

    home.sessionVariables = {
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
      DIRENV_LOG_FORMAT = "";
      NIXOS_OZONE_WL = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      GDK_SCALE = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      XDG_BACKEND = "wayland";
    };

    home.packages = with pkgs; [xwayland-satellite];
    programs.niri.settings = {
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
      cursor.hide-when-typing = true;
      clipboard.disable-primary = true;
      hotkey-overlay.skip-at-startup = true;
      animations = {
        enable = true;
        workspace-switch = {
          enable = true;
          kind = {
            spring = {
              damping-ratio = 1.0;
              stiffness = 1000;
              epsilon = 0.0001;
            };
          };
        };
        window-open = {
          enable = true;
          kind = {
            easing = {
              duration-ms = 150;
              curve = "ease-out-expo";
              curve-args = [];
            };
          };
        };
        window-close = {
          enable = true;
          kind.easing = {
            duration-ms = 150;
            curve = "ease-out-quad";
            curve-args = [];
          };
        };
        horizontal-view-movement = {
          enable = true;
          kind.spring = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
        };
        window-movement = {
          enable = true;
          kind.spring = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
        };
        window-resize = {
          enable = true;
          kind.spring = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
        };
        config-notification-open-close = {
          enable = true;
          kind.spring = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
        };
        exit-confirmation-open-close = {
          enable = true;
          kind.spring = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
        };
        screenshot-ui-open = {
          enable = true;
          kind.easing = {
            duration-ms = 150;
            curve = "ease-out-quad";
            curve-args = [];
          };
        };
        overview-open-close = {
          enable = true;
          kind.spring = {
            damping-ratio = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
        };
      };

      input = {
        mod-key = "Super";
        focus-follows-mouse.enable = true;
      };

      window-rules = [
        {
          matches = [
            {
              title = "Extension: (Bitwarden Password Manager) - Bitwarden — Zen Twilight";
            }
          ];
          open-floating = true;
          default-window-height = {
            proportion = 0.2;
          };
          default-column-width = {
            proportion = 0.2;
          };
          block-out-from = "screen-capture";
        }
      ];

      layout = {
        border.enable = false;
        focus-ring.enable = false;
        always-center-single-column = true;
        tab-indicator.hide-when-single-tab = true;
      };

      gestures = {
        hot-corners.enable = false;
      };

      binds = with config.lib.niri.actions;
        (
          {}
          // (builtins.foldl' (acc: x: acc // x) {} (
            builtins.genList (
              i: let
                ws = toString (i + 1);
              in {
                "Mod+${ws}".action = focus-workspace (i + 1);
                "Mod+Shift+${ws}".action = spawn [
                  "sh"
                  "-c"
                  "niri msg action move-window-to-workspace ${ws}"
                ];
              }
            )
            9
          ))
        )
        // {
          "Mod+Q".action = spawn [
            "sh"
            "-c"
            "kitty || wezterm"
          ];
          "Mod+C".action = close-window;
          "Mod+Shift+P".action = spawn [
            "sh"
            "-c"
            "niri msg action toggle-window-floating && niri msg action center-window && niri msg action focus-floating"
          ];
          "Mod+V".action = maximize-column;
          "Mod+Shift+E".action = quit {skip-confirmation = true;};
          "Mod+Tab".action = toggle-overview;
          "F11".action = spawn [
            "sh"
            "-c"
            "niri msg action fullscreen-window"
          ];
          "Mod+Up".action = focus-window-up-or-bottom;
          "Mod+Down".action = focus-window-down-or-top;
          "Mod+Left".action = focus-column-or-monitor-left;
          "Mod+Right".action = focus-column-or-monitor-right;
          "Mod+Shift+Up".action = move-column-to-monitor-up;
          "Mod+Shift+Down".action = move-column-to-monitor-down;
          "Mod+Shift+Left".action = move-column-left-or-to-monitor-left;
          "Mod+Shift+Right".action = move-column-right-or-to-monitor-right;
          "Mod+Ctrl+Up".action = move-window-up-or-to-workspace-up;
          "Mod+Ctrl+Down".action = move-window-down-or-to-workspace-down;
          "Mod+Ctrl+Left".action = consume-or-expel-window-left;
          "Mod+Ctrl+Right".action = consume-or-expel-window-right;
          "Mod+Alt+Up".action = focus-monitor-up;
          "Mod+Alt+Down".action = focus-monitor-down;
          "Mod+Alt+Left".action = focus-monitor-left;
          "Mod+Alt+Right".action = focus-monitor-right;
          "Mod+WheelScrollUp".action = focus-workspace-up;
          "Mod+TouchpadScrollUp".action = focus-workspace-up;
          "Mod+WheelScrollDown".action = focus-workspace-down;
          "Mod+TouchpadScrollDown".action = focus-workspace-down;
          "Alt+P".action = spawn [
            "sh"
            "-c"
            "niri msg action screenshot"
          ];
          "Alt+Shift+P".action = spawn [
            "sh"
            "-c"
            "niri msg action screenshot-screen"
          ];
          "Ctrl+Alt+P".action = spawn [
            "sh"
            "-c"
            "niri msg action screenshot-window"
          ];
          "Mod+Equal".action = spawn [
            "sh"
            "-c"
            "wpctl set-volume @DEFAULT_SINK@ 5%+"
          ];
          "Mod+Minus".action = spawn [
            "sh"
            "-c"
            "wpctl set-volume @DEFAULT_SINK@ 5%-"
          ];
          "Mod+T".action = toggle-column-tabbed-display;
        };

      outputs =
        lib.mapAttrs' (name: monitor: {
          name = monitor.name;
          value = formatMonitor monitor;
        })
        config.monitors;
    };
  };
}

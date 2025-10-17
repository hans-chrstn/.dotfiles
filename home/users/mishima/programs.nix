{ inputs, pkgs, config, ...}:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  programs.niri.settings = {
    prefer-no-csd = true;
    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
    cursor.hide-when-typing = true;
    clipboard.disable-primary = true;
    hotkey-overlay.skip-at-startup = true;
    environment = {
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
        open-maximized = true;
      }
    ];

    layout = {
      border.enable = false;
      focus-ring.enable = false;
      default-column-display = "tabbed";
      always-center-single-column = true;
      tab-indicator.hide-when-single-tab = true;
    };

    gestures = {
      hot-corners.enable = false;
    };

    binds = with config.lib.niri.actions;
    ({} // (
      builtins.foldl' (acc: x: acc // x) {} 
        (builtins.genList (i: let ws = toString (i + 1); in {
          "Mod+${ws}".action = focus-workspace (i + 1);
          "Mod+Shift+${ws}".action = spawn ["sh" "-c" "niri msg action move-window-to-workspace ${ws} && maximize-column"];
        }) 9)
    )) // 
    {
      "Mod+Q".action = spawn "kitty";
      "Mod+C".action = close-window;
      "Mod+Shift+P".action = spawn ["sh" "-c" "niri msg action toggle-window-floating && niri msg action center-window && niri msg action focus-floating"];
      "Mod+V".action = maximize-window-to-edges;
      "Mod+Shift+E".action = quit { skip-confirmation = true; };
      "Mod+Tab".action = toggle-overview;
      "F11".action = toggle-windowed-fullscreen;
      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Up".action = focus-window-top;
      "Mod+Down".action = focus-window-bottom;
      "Mod+Shift+Left".action = move-column-left;
      "Mod+Shift+Right".action = move-column-right;
      "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;
      "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
      "Mod+WheelScrollUp".action = focus-workspace-up;
      "Mod+TouchpadScrollUp".action = focus-workspace-up;
      "Mod+WheelScrollDown".action = focus-workspace-down;
      "Mod+TouchpadScrollDown".action = focus-workspace-down;
      "Alt+P".action = screenshot;
      "Alt+Shift+P".action = screenshot-window;
      "Mod+T".action = toggle-column-tabbed-display;
    };

    outputs = {
      "HDMI-A-1" = {
        enable = true;
        transform.rotation = 270;
        position = { x = -1080; y = -1080; };
        mode = {
          width = 1920;
          height = 1080;
          refresh = 74.973;
        };
      };
      "HDMI-A-2" = {
        enable = true;
        position = { x = 0; y = -1080; };
        mode = {
          width = 1920;
          height = 1080;
          refresh = 59.939;
        };
      };
      "HDMI-A-3" = {
        enable = true;
        position = { x = 0; y = 0; };
        mode = {
          width = 1920;
          height = 1080;
          refresh = 100.001;
        };
      };
    };
  };

  home.packages = with pkgs; [
    libreoffice-qt
    (discord.override {
      # withOpenASAR = true;
      withVencord = true;
    })
    discord-rpc
    # obsidian
    moonlight-qt

    # EDITING
    #davinci-resolve
    # lmms

    # TIME
    tenki

    brave
    libva-utils
    mesa-demos
    openssl
    ethtool
  ];
}

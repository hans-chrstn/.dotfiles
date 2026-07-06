{
  lib,
  config,
  ...
}: {
  options.mod.desktop.keybinds = {
    enable = lib.mkEnableOption "Enable generic keybinds API";
    modifier = lib.mkOption {
      type = lib.types.str;
      default = "Super";
      description = "The main modifier key (e.g. Super, Alt)";
    };
    terminal = lib.mkOption {
      type = lib.types.str;
      default = "kitty || wezterm";
      description = "Terminal emulator command";
    };
    workspaces = {
      enable = lib.mkEnableOption "Enable 1-9 workspace keybinds";
      count = lib.mkOption {
        type = lib.types.int;
        default = 9;
      };
    };
    actions = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          action = lib.mkOption {type = lib.types.str;};
          arg = lib.mkOption {
            type = lib.types.str;
            default = "";
          };
        };
      });
      default = {};
      description = "Mapping of 'Mod+Key' to abstract actions (e.g. { 'Mod+C' = { action = 'close'; }; })";
    };
  };

  config = lib.mkIf config.mod.desktop.keybinds.enable {
    # Default actions populated globally so any WM can translate them
    mod.desktop.keybinds.actions = {
      "Mod+Q" = {
        action = "spawn";
        arg = "terminal";
      };
      "Mod+C" = {action = "close";};
      "Mod+Shift+P" = {action = "toggle_float";};
      "Mod+V" = {action = "maximize";};
      "Mod+Shift+E" = {action = "quit";};
      "Mod+Tab" = {action = "toggle_overview";};
      "F11" = {action = "fullscreen";};

      # Focus
      "Mod+Up" = {action = "focus_up";};
      "Mod+Down" = {action = "focus_down";};
      "Mod+Left" = {action = "focus_left";};
      "Mod+Right" = {action = "focus_right";};
      "Mod+Alt+Up" = {action = "focus_monitor_up";};
      "Mod+Alt+Down" = {action = "focus_monitor_down";};
      "Mod+Alt+Left" = {action = "focus_monitor_left";};
      "Mod+Alt+Right" = {action = "focus_monitor_right";};

      # Move
      "Mod+Shift+Up" = {action = "move_up";};
      "Mod+Shift+Down" = {action = "move_down";};
      "Mod+Shift+Left" = {action = "move_left";};
      "Mod+Shift+Right" = {action = "move_right";};

      # Consume/Expel
      "Mod+Ctrl+Left" = {action = "consume_left";};
      "Mod+Ctrl+Right" = {action = "consume_right";};
      "Mod+Ctrl+Up" = {action = "move_up_workspace";};
      "Mod+Ctrl+Down" = {action = "move_down_workspace";};

      # Resize
      "Ctrl+Alt+Left" = {action = "resize_width_down";};
      "Ctrl+Alt+Right" = {action = "resize_width_up";};

      # Scroll workspaces
      "Mod+WheelScrollUp" = {action = "workspace_up";};
      "Mod+TouchpadScrollUp" = {action = "workspace_up";};
      "Mod+WheelScrollDown" = {action = "workspace_down";};
      "Mod+TouchpadScrollDown" = {action = "workspace_down";};

      # Media/Screenshots
      "Alt+P" = {action = "screenshot";};
      "Alt+Shift+P" = {action = "screenshot_screen";};
      "Ctrl+Alt+P" = {action = "screenshot_window";};
      "Mod+Equal" = {action = "volume_up";};
      "Mod+Minus" = {action = "volume_down";};

      "Mod+T" = {action = "toggle_tabbed";};
    };

    mod.desktop.keybinds.workspaces.enable = true;
  };
}

{
  lib,
  config,
  ...
}: let
  cfg = config.mod.programs.wezterm;
in {
  options.mod.programs.wezterm = {
    enable = lib.mkEnableOption "Enable the WezTerm feature";

    window = {
      decorations = lib.mkOption {
        type = lib.types.enum ["FULL" "RESIZE" "NONE" "TITLE | RESIZE"];
        default = "RESIZE";
        description = "Window decorations (title bar).";
      };
      padding = lib.mkOption {
        type = with lib.types; attrsOf int;
        default = {
          left = 10;
          right = 10;
          top = 10;
          bottom = 5;
        };
        description = "Internal window padding in pixels.";
      };
      adjustWindowSizeWhenChangingFontSize = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Adjust window size when font size changes";
      };
      initialRows = lib.mkOption {
        type = lib.types.int;
        default = 24;
      };
      initialCols = lib.mkOption {
        type = lib.types.int;
        default = 80;
      };
      lineHeight = lib.mkOption {
        type = lib.types.float;
        default = 1.0;
      };
      boldBrightensAnsiColors = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Make bold text brighten ANSI colors";
      };
      warnAboutMissingGlyphs = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Show a warning for missing font glyphs";
      };
    };

    tabBar = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable the tab bar";
      };
      hideIfOnlyOneTab = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Hide the tab bar with only one tab";
      };
      atBottom = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Position the tab bar at the bottom";
      };
      useFancy = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Use the 'fancy' tab bar style";
      };
      showNewTabButton = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Show the new tab button";
      };
      showCloseTabButton = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Show the close tab button";
      };
      showTabIndex = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Show the tab index number";
      };
      maxWidth = lib.mkOption {
        type = lib.types.int;
        default = 256;
      };
    };

    behavior = {
      quitWhenAllWindowsAreClosed = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Exit server when last window closes";
      };
      scrollbackLines = lib.mkOption {
        type = lib.types.int;
        default = 5000;
      };
      audibleBell = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable the audible bell";
      };
      automaticallyReloadConfig = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Auto-reload config on change";
      };
      scrollToBottomOnInput = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Scroll to bottom on input";
      };
      defaultCwd = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
      exitBehavior = lib.mkOption {
        type = lib.types.enum ["Close" "Hide" "Hold"];
        default = "Close";
        description = "What to do when a tab's process exits.";
      };
      hideMouseCursorWhenTyping = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Hide mouse cursor when typing";
      };
      paneFocusFollowsMouse = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Focus panes by hovering the mouse";
      };
      checkForUpdates = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Periodically check for WezTerm updates";
      };
      skipCloseConfirmationForProcesses = lib.mkOption {
        type = with lib.types; listOf str;
        default = ["zsh" "bash" "fish"];
        description = "List of process names that can be closed without confirmation.";
      };
    };

    performance = {
      frontEnd = lib.mkOption {
        type = lib.types.enum ["WebGpu" "OpenGL" "Software"];
        default = "OpenGL";
      };
      maxFps = lib.mkOption {
        type = lib.types.int;
        default = 60;
      };
      animationFps = lib.mkOption {
        type = lib.types.int;
        default = 60;
      };
      webgpuPowerPreference = lib.mkOption {
        type = lib.types.enum ["HighPerformance" "LowPower"];
        default = "HighPerformance";
      };
    };

    cursor = {
      style = lib.mkOption {
        type = lib.types.enum ["SteadyBlock" "BlinkingBlock" "SteadyBar" "BlinkingBar"];
        default = "BlinkingBlock";
      };
      blinkRate = lib.mkOption {
        type = lib.types.int;
        default = 500;
      };
      thickness = lib.mkOption {
        type = lib.types.nullOr (lib.types.enum ["Cell" "Half" "Thin" "Wide"]);
        default = null;
      };
    };

    keybinds = {
      disableDefaultKeyBindings = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Disable default WezTerm keybindings";
      };
    };

    shell = {
      defaultProg = lib.mkOption {
        type = lib.types.nullOr (lib.types.listOf lib.types.str);
        default = null;
      };
      term = lib.mkOption {
        type = lib.types.str;
        default = "wezterm";
      };
      enableWayland = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable Wayland integration";
      };
      enableKittyKeyboard = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable Kitty keyboard protocol for better key handling";
      };
    };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Arbitrary Lua code to append. Use this for complex options like keybinds or rules.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;

      extraConfig = ''
        -- WINDOW & APPEARANCE
        config.window_decorations = "${cfg.window.decorations}"
        config.window_padding = {
          left = ${builtins.toString cfg.window.padding.left}, right = ${builtins.toString cfg.window.padding.right},
          top = ${builtins.toString cfg.window.padding.top}, bottom = ${builtins.toString cfg.window.padding.bottom},
        }
        config.adjust_window_size_when_changing_font_size = ${lib.boolToString cfg.window.adjustWindowSizeWhenChangingFontSize}
        config.initial_rows = ${builtins.toString cfg.window.initialRows}
        config.initial_cols = ${builtins.toString cfg.window.initialCols}
        config.line_height = ${builtins.toString cfg.window.lineHeight}
        config.bold_brightens_ansi_colors = ${lib.boolToString cfg.window.boldBrightensAnsiColors}
        config.warn_about_missing_glyphs = ${lib.boolToString cfg.window.warnAboutMissingGlyphs}

        -- TAB BAR
        config.enable_tab_bar = ${lib.boolToString cfg.tabBar.enable}
        config.hide_tab_bar_if_only_one_tab = ${lib.boolToString cfg.tabBar.hideIfOnlyOneTab}
        config.tab_bar_at_bottom = ${lib.boolToString cfg.tabBar.atBottom}
        config.use_fancy_tab_bar = ${lib.boolToString cfg.tabBar.useFancy}
        config.show_new_tab_button_in_tab_bar = ${lib.boolToString cfg.tabBar.showNewTabButton}
        config.show_close_tab_button_in_tabs = ${lib.boolToString cfg.tabBar.showCloseTabButton}
        config.show_tab_index_in_tab_bar = ${lib.boolToString cfg.tabBar.showTabIndex}
        config.tab_max_width = ${builtins.toString cfg.tabBar.maxWidth}

        -- BEHAVIOR
        config.quit_when_all_windows_are_closed = ${lib.boolToString cfg.behavior.quitWhenAllWindowsAreClosed}
        config.scrollback_lines = ${builtins.toString cfg.behavior.scrollbackLines}
        config.audible_bell = "${
          if cfg.behavior.audibleBell
          then "SystemBeep"
          else "Disabled"
        }"
        config.automatically_reload_config = ${lib.boolToString cfg.behavior.automaticallyReloadConfig}
        config.scroll_to_bottom_on_input = ${lib.boolToString cfg.behavior.scrollToBottomOnInput}
        config.exit_behavior = "${cfg.behavior.exitBehavior}"
        config.hide_mouse_cursor_when_typing = ${lib.boolToString cfg.behavior.hideMouseCursorWhenTyping}
        config.pane_focus_follows_mouse = ${lib.boolToString cfg.behavior.paneFocusFollowsMouse}
        config.check_for_updates = ${lib.boolToString cfg.behavior.checkForUpdates}
        config.skip_close_confirmation_for_processes_named = { ${lib.concatStringsSep ", " (map (s: ''"${s}"'') cfg.behavior.skipCloseConfirmationForProcesses)} }
        ${lib.optionalString (cfg.behavior.defaultCwd != null) ''
          config.default_cwd = "${cfg.behavior.defaultCwd}"
        ''}
        config.hyperlink_rules = wezterm.default_hyperlink_rules()

        -- PERFORMANCE
        config.front_end = "${cfg.performance.frontEnd}"
        config.max_fps = ${builtins.toString cfg.performance.maxFps}
        config.animation_fps = ${builtins.toString cfg.performance.animationFps}
        config.webgpu_power_preference = "${cfg.performance.webgpuPowerPreference}"

        -- CURSOR
        config.default_cursor_style = '${cfg.cursor.style}'
        config.cursor_blink_rate = ${builtins.toString cfg.cursor.blinkRate}
        ${lib.optionalString (cfg.cursor.thickness != null) ''
          config.cursor_thickness = '${cfg.cursor.thickness}'
        ''}

        -- SHELL & INTEGRATION
        config.term = "${cfg.shell.term}"
        config.enable_wayland = ${lib.boolToString cfg.shell.enableWayland}
        config.enable_kitty_keyboard = ${lib.boolToString cfg.shell.enableKittyKeyboard}
        ${lib.optionalString (cfg.shell.defaultProg != null) ''
          config.default_prog = { ${lib.concatStringsSep ", " (map (s: ''"${s}"'') cfg.shell.defaultProg)} }
        ''}

        -- HARDCODED KEYBINDS (recommended for consistency)
        config.disable_default_key_bindings = ${lib.boolToString cfg.keybinds.disableDefaultKeyBindings}
        local LEADER = "CTRL|SHIFT"
        config.keys = {
          -- TAB MANAGEMENT
          { key = 't', mods = LEADER, action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
          { key = 'w', mods = LEADER, action = wezterm.action.CloseCurrentTab { confirm = true } },
          { key = '[', mods = LEADER, action = wezterm.action.ActivateTabRelative(-1) },
          { key = ']', mods = LEADER, action = wezterm.action.ActivateTabRelative(1) },

          -- PANE MANAGEMENT
          { key = 'h', mods = LEADER, action = wezterm.action.ActivatePaneDirection 'Left' },
          { key = 'j', mods = LEADER, action = wezterm.action.ActivatePaneDirection 'Down' },
          { key = 'k', mods = LEADER, action = wezterm.action.ActivatePaneDirection 'Up' },
          { key = 'l', mods = LEADER, action = wezterm.action.ActivatePaneDirection 'Right' },
          { key = '\\', mods = LEADER, action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
          { key = '|', mods = LEADER, action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
          { key = 'z', mods = LEADER, action = wezterm.action.TogglePaneZoomState },

          -- FONT & ZOOM
          { key = '+', mods = LEADER, action = wezterm.action.IncreaseFontSize },
          { key = '_', mods = LEADER, action = wezterm.action.DecreaseFontSize },
          { key = '0', mods = LEADER, action = wezterm.action.ResetFontSize },

          -- SCROLL & COPY
          { key = 'c', mods = LEADER, action = wezterm.action.CopyTo 'Clipboard' },
          { key = 'v', mods = LEADER, action = wezterm.action.PasteFrom 'Clipboard' },
          { key = 'u', mods = LEADER, action = wezterm.action.ScrollByPage(-0.5) },
          { key = 'd', mods = LEADER, action = wezterm.action.ScrollByPage(0.5) },
          { key = 'b', mods = LEADER, action = wezterm.action.ScrollToBottom },

          -- SEARCH & COMMANDS
          { key = 'p', mods = LEADER, action = wezterm.action.ActivateCommandPalette },
          { key = 'x', mods = LEADER, action = wezterm.action.ShowLauncher },

          -- WINDOW MANAGEMENT
          { key = 'n', mods = LEADER, action = wezterm.action.SpawnWindow },
          { key = 'm', mods = LEADER, action = wezterm.action.CloseCurrentPane { confirm = true } },
        }
        for i = 1, 9 do
          table.insert(config.keys, {
            key = tostring(i),
            mods = LEADER,
            action = wezterm.action.ActivateTab(i - 1),
          })
        end

        -- USER'S EXTRA CONFIG (escape hatch for complex settings)
        ${cfg.extraConfig}
      '';
    };
  };
}

{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.dotfiles.desktop.hyprland;

  colors =
    config.lib.stylix.colors or {
      base00 = "000000";
      base03 = "333333";
      base05 = "555555";
      base0D = "DDDDDD";
    };
  gradient = color1: color2: {
    colors = ["rgb(${color1})" "rgb(${color2})"];
    angle = 45;
  };

  inline = lib.generators.mkLuaInline;
  combo = mods: key:
    if mods == []
    then key
    else lib.concatStringsSep " + " (mods ++ [key]);
  bind = keys: disp: {_args = [keys (inline disp)];};
  bindOpts = keys: disp: opts: {_args = [keys (inline disp) opts];};
  exec = cmd: ''hl.dsp.exec_cmd("${cmd}")'';

  modKey = lib.strings.toUpper config.dotfiles.desktop.keybinds.modifier;
in {
  options.dotfiles.desktop.hyprland = {
    enable = lib.mkEnableOption "Enable the hyprland feature";
    unstable = lib.mkEnableOption "Use the unstable flake input for Hyprland";
  };

  config = lib.mkIf cfg.enable {
    dotfiles.desktop.wayland.enable = true;
    dotfiles.desktop.keybinds.enable = true;

    stylix.targets.hyprland.enable = false;

    wayland.windowManager.hyprland = {
      enable = true;
      package = lib.mkIf cfg.unstable inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      systemd.enable = true;
      configType = "lua";

      extraLuaFiles = {
        "hyprsplit/init" = {
          autoLoad = false;
          content = builtins.readFile "${inputs.hyprsplit.packages.${pkgs.stdenv.hostPlatform.system}.hyprsplitlua}/share/hyprsplit/init.lua";
        };
        "hyprload" = {
          autoLoad = true;
          content = ''
            local hs = require("hyprsplit")
            hs.config({ num_workspaces = ${toString config.dotfiles.desktop.keybinds.workspaces.count} })
            hs.monitor_priority({"HDMI-A-1", "DP-1", "DP-3"})

            if hl.plugin.hyprexpo then
              hl.config({ plugin = { hyprexpo = {
                columns = 3,
                gaps_in = 5,
                gaps_out = 0,
                bg_col = "rgb(111111)",
                workspace_method = "center current",
                gesture_distance = 200,
                cancel_key = "escape",
                show_cursor = 1,
              } } })
            end
          '';
        };
      };

      plugins = lib.mkIf (!cfg.unstable) (let
        customPkgs = pkgs.extend (_final: _prev: {
          hyprland = config.wayland.windowManager.hyprland.package;
        });
      in [
        (customPkgs.callPackage inputs.hyprexpo {})
      ]);

      settings = {
        monitor =
          lib.mapAttrsToList (_name: m: {
            output = m.name;
            mode = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
            position = "${toString m.position.x}x${toString m.position.y}";
            scale = toString m.scale;
            transform =
              if m.transform == 90
              then 1
              else if m.transform == 180
              then 2
              else if m.transform == 270
              then 3
              else 0;
          })
          config.monitors;

        workspace_rule = [
          {
            workspace = "w[tv1]s[false]";
            gaps_out = 0;
            gaps_in = 0;
          }
          {
            workspace = "f[1]s[false]";
            gaps_out = 0;
            gaps_in = 0;
          }
        ];

        window_rule = [
          {
            match = {
              float = false;
              workspace = "w[tv1]s[false]";
            };
            border_size = 0;
            rounding = 0;
          }
          {
            match = {
              float = false;
              workspace = "f[1]s[false]";
            };
            border_size = 0;
            rounding = 0;
          }
          {
            match.title = "^(Picture-in-[P|p]icture)$";
            float = true;
          }
          {
            match.class = ".*satty.*";
            float = true;
            size = ["(monitor_w*0.5)" "(monitor_h*0.5)"];
            center = true;
          }
        ];

        config = {
          input = {
            kb_layout = "us";
            follow_mouse = 1;
            follow_mouse_threshold = 15;
            focus_on_close = 1;
            accel_profile = "flat";
            touchpad = {
              tap_to_click = true;
              tap_and_drag = true;
              natural_scroll = true;
              disable_while_typing = false;
            };
          };

          binds = {
            workspace_center_on = 1;
            movefocus_cycles_fullscreen = true;
            workspace_back_and_forth = true;
            drag_threshold = 30;
          };

          gestures = {
            workspace_swipe_use_r = false;
            workspace_swipe_create_new = true;
          };

          general = {
            gaps_in = 3;
            gaps_out = 3;
            float_gaps = 3;
            border_size = 2;
            layout = "dwindle";
            resize_on_border = true;
            "col.active_border" = gradient colors.base0D colors.base05;
          };

          animations = {
            enabled = true;
          };

          misc = {
            disable_autoreload = true;
            enable_swallow = true;
            swallow_regex = "^(kitty)$";
            focus_on_activate = true;
            initial_workspace_tracking = 1;
            middle_click_paste = false;
            on_focus_under_fullscreen = 2;
            force_default_wallpaper = 0;
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            vrr = 1;
          };

          render.direct_scanout = 1;

          group = {
            auto_group = true;
            insert_after_current = true;
            drag_into_group = 2;
            merge_groups_on_drag = true;
            merge_groups_on_groupbar = true;
            group_on_movetoworkspace = false;
            "col.border_active" = gradient colors.base05 colors.base0D;
            "col.border_inactive" = gradient colors.base05 colors.base03;
          };

          decoration = {
            rounding = 10;
            rounding_power = 3.0;
            dim_special = 0.3;
            blur = {
              enabled = true;
              brightness = 1.0;
              contrast = 1.0;
              passes = 2;
              input_methods = true;
            };
            shadow = {
              enabled = true;
              offset = "0 2";
              range = 20;
            };
          };
        };

        bind = let
          kb = config.dotfiles.desktop.keybinds;

          mapAction = act: arg:
            if act == "spawn"
            then
              exec (
                if arg == "terminal"
                then kb.terminal
                else arg
              )
            else if act == "close"
            then "hl.dsp.window.close()"
            else if act == "toggle_float"
            then "hl.dsp.window.float({ action = \"toggle\" })"
            else if act == "maximize"
            then "hl.dsp.window.fullscreen({ mode = \"maximized\", action = \"toggle\" })"
            else if act == "quit"
            then "hl.dsp.exit()"
            else if act == "launcher"
            then exec kb.launcher
            else if act == "toggle_overview"
            then "function() if hl.plugin.hyprexpo then hl.plugin.hyprexpo.expo(\"toggle\") end end"
            else if act == "focus_up"
            then "hl.dsp.focus({ direction = \"u\" })"
            else if act == "focus_down"
            then "hl.dsp.focus({ direction = \"d\" })"
            else if act == "focus_left"
            then "hl.dsp.focus({ direction = \"l\" })"
            else if act == "focus_right"
            then "hl.dsp.focus({ direction = \"r\" })"
            else if act == "move_up"
            then "hl.dsp.window.move({ direction = \"u\" })"
            else if act == "move_down"
            then "hl.dsp.window.move({ direction = \"d\" })"
            else if act == "move_left"
            then "hl.dsp.window.move({ direction = \"l\" })"
            else if act == "move_right"
            then "hl.dsp.window.move({ direction = \"r\" })"
            else if act == "move_up_workspace"
            then "require(\"hyprsplit\").dsp.window.move({ workspace = \"+1\", follow = false })"
            else if act == "move_down_workspace"
            then "require(\"hyprsplit\").dsp.window.move({ workspace = \"-1\", follow = false })"
            else if act == "workspace_up"
            then "require(\"hyprsplit\").dsp.focus({ workspace = \"r+1\" })"
            else if act == "workspace_down"
            then "require(\"hyprsplit\").dsp.focus({ workspace = \"r-1\" })"
            else if act == "screenshot"
            then exec "grim -o $(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name') -t ppm - | satty --filename - -c ~/.config/satty/satty_config"
            else if act == "screenshot_screen"
            then exec "grim -t ppm - | satty --filename - -c ~/.config/satty/satty_config"
            else if act == "screenshot_window"
            then exec "grim -g \\\"$(hyprctl activewindow -j | jq -r '(.at | join(\\\",\\\")) + \\\" \\\" + (.size | join(\\\"x\\\"))')\\\" -t ppm - | satty --filename - -c ~/.config/satty/satty_config"
            else if act == "fullscreen"
            then "hl.dsp.window.fullscreen({ mode = \"fullscreen\", action = \"toggle\" })"
            else if act == "volume_up"
            then exec "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
            else if act == "volume_down"
            then exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            else null;

          actionBinds = lib.mapAttrsToList (key: val: let
            cmd = mapAction val.action val.arg;
            hyprKey =
              builtins.replaceStrings
              [
                "Mod+Shift+Ctrl+Alt+"
                "Mod+Shift+Ctrl+"
                "Mod+Shift+Alt+"
                "Mod+Ctrl+Alt+"
                "Mod+Shift+"
                "Mod+Ctrl+"
                "Mod+Alt+"
                "Ctrl+Alt+"
                "Alt+Shift+"
                "Mod+"
                "Alt+"
                "Ctrl+"
                "TouchpadScrollUp"
                "TouchpadScrollDown"
                "WheelScrollUp"
                "WheelScrollDown"
                "Equal"
                "Minus"
                "Up"
                "Down"
                "Left"
                "Right"
              ]
              [
                "${modKey} + SHIFT + CTRL + ALT + "
                "${modKey} + SHIFT + CTRL + "
                "${modKey} + SHIFT + ALT + "
                "${modKey} + CTRL + ALT + "
                "${modKey} + SHIFT + "
                "${modKey} + CTRL + "
                "${modKey} + ALT + "
                "CTRL + ALT + "
                "ALT + SHIFT + "
                "${modKey} + "
                "ALT + "
                "CTRL + "
                "mouse_up"
                "mouse_down"
                "mouse_up"
                "mouse_down"
                "equal"
                "minus"
                "up"
                "down"
                "left"
                "right"
              ]
              key;
          in
            if cmd != null
            then bind hyprKey cmd
            else null)
          kb.actions;

          validBinds = builtins.filter (x: x != null) actionBinds;

          workspaceBinds =
            if kb.workspaces.enable
            then
              builtins.concatLists (builtins.genList (i: let
                  ws = toString (i + 1);
                in [
                  (bind "${modKey} + ${ws}" "require(\"hyprsplit\").dsp.focus({ workspace = ${ws} })")
                  (bind "${modKey} + SHIFT + ${ws}" "require(\"hyprsplit\").dsp.window.move({ workspace = ${ws}, follow = false })")
                ])
                kb.workspaces.count)
            else [];

          advancedBinds = [
            (bind (combo [modKey "SHIFT"] "Escape") ''hl.dsp.submap("inhibit")'')
            (bind (combo [modKey] "R") ''hl.dsp.submap("resize")'')
            (bind (combo [modKey] "M") ''hl.dsp.submap("move")'')

            (bind (combo [modKey] "0") ''hl.dsp.workspace.toggle_special("Stash")'')
            (bind (combo [modKey "SHIFT"] "0") (exec "pypr toggle_special Stash"))

            (bind (combo [modKey "SHIFT"] "space") "hl.dsp.group.toggle()")
            (bind (combo ["ALT"] "grave") "hl.dsp.group.next()")
            (bind (combo ["ALT" "SHIFT"] "grave") "hl.dsp.group.prev()")
            (bind (combo [modKey "CTRL"] "left") ''hl.dsp.window.move({ into_group = "left" })'')
            (bind (combo [modKey "CTRL"] "right") ''hl.dsp.window.move({ into_group = "right" })'')
            (bind (combo [modKey "CTRL"] "up") ''hl.dsp.window.move({ into_group = "up" })'')
            (bind (combo [modKey "CTRL"] "down") ''hl.dsp.window.move({ into_group = "down" })'')

            (bindOpts "${modKey} + mouse:272" "hl.dsp.window.drag()" {mouse = true;})
            (bindOpts "${modKey} + mouse:273" "hl.dsp.window.resize()" {mouse = true;})

            (bind "ALT + Tab" "function() if hl.plugin.hyprexpo then hl.plugin.hyprexpo.expo(\"toggle\") end end")
          ];
        in
          validBinds ++ workspaceBinds ++ advancedBinds;
      };

      submaps = {
        inhibit.settings.bind = [
          (bind (combo [modKey "SHIFT"] "Escape") ''hl.dsp.submap("reset")'')
        ];
        resize.settings.bind = [
          (bindOpts (combo [] "right") ''hl.dsp.window.resize({ x = 10, y = 0, relative = true })'' {repeating = true;})
          (bindOpts (combo [] "left") ''hl.dsp.window.resize({ x = -10, y = 0, relative = true })'' {repeating = true;})
          (bindOpts (combo [] "up") ''hl.dsp.window.resize({ x = 0, y = -10, relative = true })'' {repeating = true;})
          (bindOpts (combo [] "down") ''hl.dsp.window.resize({ x = 0, y = 10, relative = true })'' {repeating = true;})
          (bind (combo [] "escape") ''hl.dsp.submap("reset")'')
          (bind (combo [modKey] "R") ''hl.dsp.submap("reset")'')
        ];
        move.settings.bind = [
          (bind (combo [] "C") "hl.dsp.window.center()")
          (bind (combo [] "P") "hl.dsp.window.pin()")
          (bind (combo [] "left") ''hl.dsp.window.move({ direction = "left", group_aware = true })'')
          (bind (combo [] "right") ''hl.dsp.window.move({ direction = "right", group_aware = true })'')
          (bind (combo [] "up") ''hl.dsp.window.move({ direction = "up", group_aware = true })'')
          (bind (combo [] "down") ''hl.dsp.window.move({ direction = "down", group_aware = true })'')
          (bind (combo ["SHIFT"] "left") ''hl.dsp.window.move({ x = -30, y = 0, relative = true })'')
          (bind (combo ["SHIFT"] "right") ''hl.dsp.window.move({ x = 30, y = 0, relative = true })'')
          (bind (combo ["SHIFT"] "up") ''hl.dsp.window.move({ x = 0, y = -30, relative = true })'')
          (bind (combo ["SHIFT"] "down") ''hl.dsp.window.move({ x = 0, y = 30, relative = true })'')
          (bindOpts (combo [] "mouse:272") "hl.dsp.window.drag()" {mouse = true;})
          (bind (combo [] "escape") ''hl.dsp.submap("reset")'')
          (bind (combo [modKey] "M") ''hl.dsp.submap("reset")'')
        ];
      };

      extraConfig = ''
        hl.curve("smooth_out", { type = "bezier", points = { {0.23, 1.0}, {0.32, 1.0} } })
        hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "smooth_out", style = "slidevert" })
      '';
    };
  };
}

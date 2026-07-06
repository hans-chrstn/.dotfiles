{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.mod.wm.hyprland;

  formatMonitor = monitor: let
    res = "${toString monitor.width}x${toString monitor.height}@${toString monitor.refreshRate}";
    pos = "${toString monitor.position.x}x${toString monitor.position.y}";
    scale = toString monitor.scale;
    transformStr =
      if monitor.transform == 90
      then ",transform,1"
      else if monitor.transform == 180
      then ",transform,2"
      else if monitor.transform == 270
      then ",transform,3"
      else "";
  in "${monitor.name},${res},${pos},${scale}${transformStr}";
in {
  options.mod.wm.hyprland = {
    enable = lib.mkEnableOption "Enable the hyprland feature";
  };

  config = lib.mkIf cfg.enable {
    # Enable global desktop abstractions automatically when Hyprland is enabled
    mod.desktop.wayland.enable = true;
    mod.desktop.keybinds.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;

      settings = {
        monitor = lib.mapAttrsToList (name: m: formatMonitor m) config.monitors;

        # Core Settings
        input = {
          kb_layout = "us";
          follow_mouse = 1;
          touchpad.natural_scroll = true;
        };

        general = {
          gaps_in = 3;
          gaps_out = 3;
          border_size = 2;
          layout = "dwindle";
          resize_on_border = true;
        };

        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 3;
            passes = 2;
          };
          shadow = {
            enabled = true;
            range = 20;
            render_power = 3;
          };
        };

        animations = {
          enabled = true;
          bezier = [
            "overshoot, 0.05, 0.9, 0.1, 1.05"
            "snappy, 0.2, 1.0, 0.25, 1.0"
          ];
          animation = [
            "windows, 1, 3, overshoot, popin 70%"
            "windowsOut, 1, 3, snappy, popin 70%"
            "border, 1, 5, default"
            "fade, 1, 3, snappy"
            "workspaces, 1, 4, snappy, slidevert"
          ];
        };

        # Window Rules (Smart Gaps)
        workspace = [
          "w[tv1], gapsout:0, gapsin:0"
          "f[1], gapsout:0, gapsin:0"
        ];
        windowrulev2 = [
          "bordersize 0, floating:0, onworkspace:w[tv1]"
          "rounding 0, floating:0, onworkspace:w[tv1]"
          "bordersize 0, floating:0, onworkspace:f[1]"
          "rounding 0, floating:0, onworkspace:f[1]"
        ];

        # Keybinds mapping
        bind = let
          kb = config.mod.desktop.keybinds;
          mod = kb.modifier;

          # Convert standard abstract actions to Hyprland commands
          mapAction = act: arg:
            if act == "spawn"
            then
              "exec, "
              + (
                if arg == "terminal"
                then kb.terminal
                else arg
              )
            else if act == "close"
            then "killactive,"
            else if act == "toggle_float"
            then "togglefloating,"
            else if act == "maximize"
            then "fullscreen, 1"
            else if act == "quit"
            then "exit,"
            else if act == "fullscreen"
            then "fullscreen, 0"
            else if act == "focus_up"
            then "movefocus, u"
            else if act == "focus_down"
            then "movefocus, d"
            else if act == "focus_left"
            then "movefocus, l"
            else if act == "focus_right"
            then "movefocus, r"
            else if act == "focus_monitor_up"
            then "focusmonitor, u"
            else if act == "focus_monitor_down"
            then "focusmonitor, d"
            else if act == "focus_monitor_left"
            then "focusmonitor, l"
            else if act == "focus_monitor_right"
            then "focusmonitor, r"
            else if act == "move_up"
            then "movewindow, u"
            else if act == "move_down"
            then "movewindow, d"
            else if act == "move_left"
            then "movewindow, l"
            else if act == "move_right"
            then "movewindow, r"
            else if act == "move_up_workspace"
            then "movetoworkspace, m-1"
            else if act == "move_down_workspace"
            then "movetoworkspace, m+1"
            else if act == "resize_width_down"
            then "resizeactive, -50 0"
            else if act == "resize_width_up"
            then "resizeactive, 50 0"
            else if act == "workspace_up"
            then "workspace, e+1"
            else if act == "workspace_down"
            then "workspace, e-1"
            else if act == "screenshot"
            then "exec, grim"
            else if act == "volume_up"
            then "exec, wpctl set-volume @DEFAULT_SINK@ 5%+"
            else if act == "volume_down"
            then "exec, wpctl set-volume @DEFAULT_SINK@ 5%-"
            else null;

          actionBinds = lib.mapAttrsToList (key: val: let
            cmd = mapAction val.action val.arg;
            # Translate text keys to Hyprland modifier syntax
            hyprKey =
              builtins.replaceStrings
              ["Mod+Shift+Ctrl+Alt+" "Mod+Shift+Ctrl+" "Mod+Shift+Alt+" "Mod+Ctrl+Alt+" "Mod+Shift+" "Mod+Ctrl+" "Mod+Alt+" "Ctrl+Alt+" "Alt+Shift+" "Mod+" "Alt+" "Ctrl+"]
              ["${mod} SHIFT CTRL ALT, " "${mod} SHIFT CTRL, " "${mod} SHIFT ALT, " "${mod} CTRL ALT, " "${mod} SHIFT, " "${mod} CTRL, " "${mod} ALT, " "CTRL ALT, " "ALT SHIFT, " "${mod}, " "ALT, " "CTRL, "]
              key;
          in
            if cmd != null
            then "${hyprKey}, ${cmd}"
            else "")
          kb.actions;

          validBinds = builtins.filter (x: x != "") actionBinds;

          workspaceBinds =
            if kb.workspaces.enable
            then
              builtins.concatLists (builtins.genList (i: let
                  ws = toString (i + 1);
                in [
                  "${mod}, ${ws}, workspace, ${ws}"
                  "${mod} SHIFT, ${ws}, movetoworkspace, ${ws}"
                ])
                kb.workspaces.count)
            else [];
        in
          validBinds ++ workspaceBinds;

        bindm = let
          mod = config.mod.desktop.keybinds.modifier;
        in [
          "${mod}, mouse:272, movewindow"
          "${mod}, mouse:273, resizewindow"
        ];
      };
    };
  };
}

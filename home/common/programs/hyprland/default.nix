{  inputs, pkgs, ... }:

{

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd.variables = ["--all"];
    plugins = [
      inputs.hyprsplit.packages.${pkgs.system}.hyprsplit
    ];
    settings = {
      "$mainMod" = "SUPER";
      "$menu" = "ags -t applauncher";
      "$fileManager" = "kitty -e lf";
      "$terminal" = "kitty";

      plugin = {
        hyprsplit = {
          "count" = "10"; 
        };
      };

      bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
      ];

      bindl = [
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioStop, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
      ];

      bindel = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"

      ];

      bind = [
          ", XF86HomePage, split:workspace, 1"
          #", XF86HomePage, workspace, 1"
          ", XF86Mail, exec, spotify"
          ", Pause, exec, floorp"
          ", Scroll_Lock, exec, pokemmo"
          ", Menu, exec, $terminal"

          "$mainMod, Print, exec, hyprshot -m region"
          "$mainMod SHIFT, Print, exec, hyprshot -m window"
          "$mainMod ALT, Print, exec, hyprshot -m output"

          "$mainMod, Q, exec, $terminal"
          "$mainMod, C, killactive"
          "$mainMod, M, exit"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating"
          "$mainMod, P, pseudo" # dwindle
          "$mainMod, J, togglesplit" # dwindle
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          "$mainMod SHIFT, left, movewindow, l"
          "$mainMod SHIFT, right, movewindow, r"
          "$mainMod SHIFT, up, movewindow, u"
          "$mainMod SHIFT, down, movewindow, d"

          "$mainMod CONTROL, left,  resizeactive, -10 0"
          "$mainMod CONTROL, right, resizeactive, 10 0"
          "$mainMod CONTROL, up,    resizeactive, 0 -10"
          "$mainMod CONTROL, down,  resizeactive, 0 10"


          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"

          "$mainMod, mouse_down, split:workspace, e+1"
          "$mainMod, mouse_up, split:workspace, e-1"
          #"$mainMod, mouse_down, workspace, e+1"
          #"$mainMod, mouse_up, workspace, e-1"


          "ALT, Tab, cyclenext"
          "ALT Shift, Tab, cyclenext, prev"

          "$mainMod, G, togglegroup"
          "$mainMod SHIFT, G, lockgroups, toggle"
          "$mainMod, tab, changegroupactive"

          "$mainMod ALT, left,  moveintogroup, l"
          "$mainMod ALT, right, moveintogroup, r"
          "$mainMod ALT, up,    moveintogroup, u"
          "$mainMod ALT, down,  moveintogroup, d"

          "$mainMod SHIFT ALT, left,  moveoutofgroup, l"
          "$mainMod SHIFT ALT, right, moveoutofgroup, r"
          "$mainMod SHIFT ALT, up,    moveoutofgroup, u"
          "$mainMod SHIFT ALT, down,  moveoutofgroup, d"

          "$mainMod, Kp_left, exec, busctl --user call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n 1000"
          "$mainMod, Kp_right, exec, busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n -1000"
          "$mainMod, Kp_up, exec, brightnessctl set 96000"
          "$mainMod, Kp_down, exec, brightnessctl set 10000"

          "$mainMod SHIFT, W, exec, ags -t bar0"
          "$mainMod ALT, W, exec, ags -t bar1"
          "$mainMod, R, exec, $menu"
          
          "$mainMod SHIFT, T, split:swapactiveworkspaces, current +1"
          "$mainMod ALT, T, split:grabroguewindows"
      ]
      ++ (
        builtins.concatLists (builtins.genList (
          x: let
            ws = let
              c = (x + 1) / 10;
            in
              builtins.toString (x + 1 - (c * 10));
          in [
            "$mainMod, ${ws}, split:workspace, ${toString (x + 1)}"
            "$mainMod SHIFT, ${ws}, split:movetoworkspace, ${toString (x + 1)}"
            "$mainMod ALT, ${ws}, split:movetoworkspacesilent, ${toString (x + 1)}"

            #"$mainMod, ${ws}, workspace, ${toString (x + 1)}"
            #"$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"

          ]
        )
        10)
      );

      monitor = [
        "HDMI-A-2,highres,0x0,1"
	      "HDMI-A-1,highres,1920x0,1"
        "eDP-1,highres,0x0,1"
      ];
        
      env = [
        "XCURSOR_SIZE, 24"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];

      input = {
        "kb_layout" = "us, kr";
        "kb_variant" = "";
        "kb_model" = "";
        "kb_options" = "grp:win_space_toggle";
        "kb_rules" = "";
        "numlock_by_default" = "true";
        "follow_mouse" = "1";
        touchpad = {
          "natural_scroll" = "false";
          "middle_button_emulation" = "true";
          "clickfinger_behavior" = "true";
        };
        "sensitivity" = "0";
      };

      general = {
        "gaps_in" = "2";
        "gaps_out" = "3";
        "border_size" = "2";
        "col.active_border" = "rgba(364f6dc8) rgba(4f6a8cee) 45degb";
        "col.inactive_border" = "rgba(1e1e1ec8) rgba(4f6a8cee) 45degb";
        "layout" = "dwindle";
        "allow_tearing" = "false";
      };

      group = {
        "col.border_active" = "rgba(364f6dc8) rgba(4f6a8cee) 45degb";
        "col.border_inactive" = "rgba(1e1e1ec8) rgba(4f6a8cee) 45degb";
    
        groupbar = {
          "enabled" = "false";
        };
      };

      decoration = {
        "rounding" = "14";

        blur = {
          "enabled" = "false";
          "special" = "false";
          "size" = "5";
          "passes" = "4";
          "ignore_opacity" = "true";
          "new_optimizations" = "true";
          "noise" = "0.03";
          "contrast" = "1.1";
          "brightness" = "0.9";
        };

        "drop_shadow" = "true";
        "dim_inactive" = "false";
        "dim_strength" = "0.1";
        "dim_special" = "0";
      };

      animations = {
        "enabled" = "true";
        bezier = [
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "fluent_decel, 0.1, 1, 0, 1"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 2, default"
          "workspaces, 1, 3.5, md3_decel, slidefadevert"
          "specialWorkspace, 1, 3, easeInOutCirc, slidefadevert 15%"
        ];

      };

      dwindle = {
        "pseudotile" = "true";
        "preserve_split" = "true";
      };

      master = {
        new_status = "master";
      };

      gestures = {
        "workspace_swipe" = "true";
        "workspace_swipe_distance" = "700";
        "workspace_swipe_fingers" = "4";
        "workspace_swipe_cancel_ratio" = "0.2";
        "workspace_swipe_min_speed_to_force" = "5";
        "workspace_swipe_direction_lock" = "true";
        "workspace_swipe_direction_lock_threshold" = "0";
        "workspace_swipe_create_new" = "true";
      };

      misc = {
        "force_default_wallpaper" = "-1"; # Set to 0 or 1 to disable the anime mascot wallpapers
        "disable_hyprland_logo" = "true";
        "disable_splash_rendering" = "true";
        "vfr" = "true";
        "vrr" = "true";

        windowrulev2 = [
          "suppressevent maximize, class:.*"
          "float, class:.*"
          "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
          "noanim,class:^(xwaylandvideobridge)$"
          "noinitialfocus,class:^(xwaylandvideobridge)$"
          "maxsize 1 1,class:^(xwaylandvideobridge)$"
          "noblur,class:^(xwaylandvideobridge)$ = 1"
        ];
        "focus_on_activate" = "true";
        "animate_manual_resizes" = "false";
        "animate_mouse_windowdragging" = "false";
        "allow_session_lock_restore" = "true";

      };

      opengl = {
        "force_introspection" = "1";
      };

      device = {
        "name" = "epic-mouse-v1";
        "sensitivity" = "-0.5";
      };

      exec-once = [
        #"bash ~/.dotfiles/home/common/programs/hyprland/config/start.sh"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP GTK_THEME"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP GTK_THEME"
        ];
    };
  };
 }

{
  modules,
  lib,
  ...
}: {
  # best i could do to simulate niri's layout
  imports = [
    modules.mangowc
  ];

  mod.programs.mangowc = let
    horizontalLayouts = ["tile" "scroller" "monocle" "grid" "dwindle" "spiral" "deck" "center_tile" "right_tile"];
    verticalLayouts = ["vertical_tile" "vertical_scroller" "vertical_grid" "vertical_dwindle" "vertical_spiral" "vertical_deck"];
    directions = ["Up" "Down" "Left" "Right"];
    moveResizeParams = {
      Up = "+0,-50";
      Down = "+0,+50";
      Left = "-50,+0";
      Right = "+50,+0";
    };
    mkDirectionalBinds = mods: command: transform:
      map (key: {
        inherit mods key command;
        params = transform key;
      })
      directions;
    mkNumberBinds = mods: command: suffix:
      builtins.genList (i: {
        inherit mods command;
        key = toString (i + 1);
        params = "${toString (i + 1)}${suffix}";
      })
      9;
    mkMoveResizeBinds = mods: command:
      lib.mapAttrsToList (key: params: {
        inherit mods key command params;
      })
      moveResizeParams;
  in {
    enable = true;
    appearance = {
      borderpx = 0;
    };
    layout = {
      scroller = {
        preferCenter = true;
        edgeScrollerPointerFocus = false;
        defaultProportion = 1.0;
      };
    };

    misc = {
      enableFloatingSnap = true;
      focusCrossMonitor = true;
      focusCrossTag = false;
    };

    overview = {
      enableHotArea = false;
      tabMode = false;
      hotAreaSize = 0;
    };

    effects = {
      borderRadius = 0;
    };

    animations = {
      openType = "zoom";
      closeType = "zoom";
      tagDirection = "horizontal";
      duration = {
        move = 200;
        open = 400;
        close = 400;
        tag = 300;
      };
    };

    tagRules = [
      {
        id = 1;
        layout_name = "scroller";
      }
      {
        id = 2;
        layout_name = "scroller";
      }
      {
        id = 3;
        layout_name = "scroller";
      }
      {
        id = 4;
        layout_name = "scroller";
      }
      {
        id = 5;
        layout_name = "scroller";
      }
      {
        id = 6;
        layout_name = "scroller";
      }
      {
        id = 7;
        layout_name = "scroller";
      }
      {
        id = 8;
        layout_name = "scroller";
      }
      {
        id = 9;
        layout_name = "scroller";
      }
    ];
    bindings =
      [
        {
          mods = ["SUPER"];
          key = "q";
          command = "spawn";
          params = "wezterm";
        }
        {
          mods = ["SUPER"];
          key = "c";
          command = "killclient";
        }
        {
          mods = ["SUPER" "SHIFT"];
          key = "e";
          command = "quit";
        }
        {
          mods = ["SUPER"];
          key = "Tab";
          command = "toggleoverview";
        }
        {
          mods = ["SUPER"];
          key = "v";
          command = "togglemaxmizescreen";
        }
        {
          mods = ["SUPER"];
          key = "p";
          command = "togglefloating";
        }
        {
          mods = ["SUPER"];
          key = "z";
          command = "toggle_scratchpad";
        }
        {
          mods = ["CTRL"];
          key = "m";
          command = "minimized";
        }
        {
          mods = ["ALT"];
          key = "m";
          command = "restore_minimized";
        }
        {
          mods = ["NONE"];
          key = "F11";
          command = "togglefullscreen";
        }
      ]
      ++ (lib.imap0 (i: layout: {
          mods = ["SUPER" "CTRL"];
          key = toString (i + 1);
          command = "setlayout";
          params = layout;
        })
        horizontalLayouts)
      ++ (lib.imap0 (i: layout: {
          mods = ["SUPER" "ALT"];
          key = toString (i + 1);
          command = "setlayout";
          params = layout;
        })
        verticalLayouts)
      ++ (mkNumberBinds ["SUPER"] "view" "")
      ++ (mkNumberBinds ["SUPER" "SHIFT"] "tag" "")
      ++ (mkMoveResizeBinds ["CTRL" "SHIFT"] "movewin")
      ++ (mkMoveResizeBinds ["CTRL" "ALT"] "resizewin")
      ++ (mkDirectionalBinds ["SUPER"] "focusdir" lib.toLower)
      ++ (mkDirectionalBinds ["SUPER" "SHIFT"] "exchange_client" lib.toLower);
  };
}

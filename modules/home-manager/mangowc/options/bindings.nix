{lib, ...}: let
  directions = [
    "Up"
    "Down"
    "Left"
    "Right"
  ];

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

  mkMoveResizeBinds = mods: command:
    lib.mapAttrsToList (key: params: {
      inherit
        mods
        key
        command
        params
        ;
    })
    moveResizeParams;

  mkNumberBinds = mods: command: suffix:
    builtins.genList (i: {
      inherit mods command;
      key = toString (i + 1);
      params = "${toString (i + 1)}${suffix}";
    })
    9;

  mkSimpleBinds = bindList:
    map (
      {
        mods,
        key,
        command,
        params ? null,
      }: {
        inherit mods key command;
        params =
          if params != null
          then params
          else null;
      }
    )
    bindList;
in {
  options.mod.programs.mangowc = {
    mouseBindings = lib.mkOption {
      type = with lib.types;
        listOf (submodule {
          options = {
            mods = lib.mkOption {
              type = listOf (enum [
                "SUPER"
                "CTRL"
                "ALT"
                "SHIFT"
                "NONE"
              ]);
              description = "Modifier keys for the mouse binding";
            };
            button = lib.mkOption {
              type = enum [
                "btn_left"
                "btn_middle"
                "btn_right"
              ];
              description = "Mouse button to bind";
            };
            command = lib.mkOption {
              type = str;
              description = "Command to execute";
            };
            params = lib.mkOption {
              type = nullOr str;
              default = null;
              description = "Optional parameters for the command";
            };
          };
        });
      default = [
        {
          mods = ["SUPER"];
          button = "btn_left";
          command = "moveresize";
          params = "curmove";
        }
        {
          mods = ["SUPER"];
          button = "btn_right";
          command = "moveresize";
          params = "curresize";
        }
        {
          mods = ["NONE"];
          button = "btn_middle";
          command = "togglemaximizescreen";
          params = "0";
        }
        {
          mods = ["NONE"];
          button = "btn_left";
          command = "toggleoverview";
          params = "-1";
        }
        {
          mods = ["NONE"];
          button = "btn_right";
          command = "killclient";
          params = "0";
        }
      ];
      description = "Mouse button bindings";
    };

    axisBindings = lib.mkOption {
      type = with lib.types;
        listOf (submodule {
          options = {
            mods = lib.mkOption {
              type = listOf (enum [
                "SUPER"
                "CTRL"
                "ALT"
                "SHIFT"
                "NONE"
              ]);
              description = "Modifier keys for the axis binding";
            };
            direction = lib.mkOption {
              type = enum [
                "UP"
                "DOWN"
                "LEFT"
                "RIGHT"
              ];
              description = "Scroll direction";
            };
            command = lib.mkOption {
              type = str;
              description = "Command to execute";
            };
            params = lib.mkOption {
              type = nullOr str;
              default = null;
              description = "Optional parameters for the command";
            };
          };
        });
      default = [
        {
          mods = ["SUPER"];
          direction = "UP";
          command = "viewtoleft_have_client";
        }
        {
          mods = ["SUPER"];
          direction = "DOWN";
          command = "viewtoright_have_client";
        }
      ];
      description = "Mouse wheel/axis bindings";
    };

    layerRules = lib.mkOption {
      type = with lib.types; listOf (attrsOf str);
      default = [
        {
          animation_type_open = "zoom";
          layer_name = "rofi";
        }
        {
          animation_type_close = "zoom";
          layer_name = "rofi";
        }
      ];
      description = "Layer-specific rules for windows (e.g., rofi, notifications)";
    };

    switchBindings = lib.mkOption {
      type = with lib.types;
        listOf (submodule {
          options = {
            foldState = lib.mkOption {
              type = enum [
                "fold"
                "unfold"
              ];
              description = "Laptop lid state";
            };
            command = lib.mkOption {
              type = str;
              description = "Command to execute";
            };
            params = lib.mkOption {
              type = nullOr str;
              default = null;
              description = "Optional parameters for the command";
            };
          };
        });
      default = [];
      description = "Laptop lid fold/unfold bindings";
    };

    gestureBindings = lib.mkOption {
      type = with lib.types;
        listOf (submodule {
          options = {
            mods = lib.mkOption {
              type = listOf (enum [
                "SUPER"
                "CTRL"
                "ALT"
                "SHIFT"
                "NONE"
              ]);
              description = "Modifier keys for the gesture";
            };
            direction = lib.mkOption {
              type = enum [
                "up"
                "down"
                "left"
                "right"
              ];
              description = "Gesture swipe direction";
            };
            fingers = lib.mkOption {
              type = int;
              description = "Number of fingers for the gesture";
            };
            command = lib.mkOption {
              type = str;
              description = "Command to execute";
            };
            params = lib.mkOption {
              type = nullOr str;
              default = null;
              description = "Optional parameters for the command";
            };
          };
        });
      default = [];
      description = "Touchpad gesture bindings";
    };

    bindings = lib.mkOption {
      type = with lib.types;
        listOf (submodule {
          options = {
            mods = lib.mkOption {
              type = listOf (enum [
                "SUPER"
                "CTRL"
                "ALT"
                "SHIFT"
                "NONE"
              ]);
              description = "Modifier keys for the binding";
            };
            key = lib.mkOption {
              type = str;
              description = "Key to bind (use output from xev/wev)";
            };
            command = lib.mkOption {
              type = str;
              description = "Command to execute";
            };
            params = lib.mkOption {
              type = nullOr str;
              default = null;
              description = "Optional parameters for the command";
            };
          };
        });
      default =
        # Core system bindings
        (mkSimpleBinds [
          {
            mods = ["SUPER"];
            key = "r";
            command = "reload_config";
          }
          {
            mods = ["ALT"];
            key = "space";
            command = "spawn";
            params = "rofi -show drun";
          }
          {
            mods = ["ALT"];
            key = "Return";
            command = "spawn";
            params = "foot";
          }
          {
            mods = ["SUPER"];
            key = "m";
            command = "quit";
          }
          {
            mods = ["ALT"];
            key = "q";
            command = "killclient";
          }
          {
            mods = ["SUPER"];
            key = "Tab";
            command = "focusstack";
            params = "next";
          }
        ])
        # Directional focus: Alt+Arrows
        ++ (mkDirectionalBinds ["ALT"] "focusdir" lib.toLower)
        # Directional swap: Super+Shift+Arrows
        ++ (mkDirectionalBinds ["SUPER" "SHIFT"] "exchange_client" lib.toLower)
        # Window status toggles
        ++ (mkSimpleBinds [
          {
            mods = ["SUPER"];
            key = "g";
            command = "toggleglobal";
          }
          {
            mods = ["ALT"];
            key = "Tab";
            command = "toggleoverview";
          }
          {
            mods = ["ALT"];
            key = "backslash";
            command = "togglefloating";
          }
          {
            mods = ["ALT"];
            key = "a";
            command = "togglemaximizescreen";
          }
          {
            mods = ["ALT"];
            key = "f";
            command = "togglefullscreen";
          }
          {
            mods = [
              "ALT"
              "SHIFT"
            ];
            key = "f";
            command = "togglefakefullscreen";
          }
          {
            mods = ["SUPER"];
            key = "i";
            command = "minimized";
          }
          {
            mods = ["SUPER"];
            key = "o";
            command = "toggleoverlay";
          }
          {
            mods = [
              "SUPER"
              "SHIFT"
            ];
            key = "I";
            command = "restore_minimized";
          }
          {
            mods = ["ALT"];
            key = "z";
            command = "toggle_scratchpad";
          }
        ])
        # Layout controls
        ++ (mkSimpleBinds [
          {
            mods = ["ALT"];
            key = "e";
            command = "set_proportion";
            params = "1.0";
          }
          {
            mods = ["ALT"];
            key = "x";
            command = "switch_proportion_preset";
          }
          {
            mods = ["SUPER"];
            key = "n";
            command = "switch_layout";
          }
        ])
        # Tag navigation
        ++ (mkSimpleBinds [
          {
            mods = ["SUPER"];
            key = "Left";
            command = "viewtoleft";
            params = "0";
          }
          {
            mods = ["CTRL"];
            key = "Left";
            command = "viewtoleft_have_client";
            params = "0";
          }
          {
            mods = ["SUPER"];
            key = "Right";
            command = "viewtoright";
            params = "0";
          }
          {
            mods = ["CTRL"];
            key = "Right";
            command = "viewtoright_have_client";
            params = "0";
          }
          {
            mods = [
              "CTRL"
              "SUPER"
            ];
            key = "Left";
            command = "tagtoleft";
            params = "0";
          }
          {
            mods = [
              "CTRL"
              "SUPER"
            ];
            key = "Right";
            command = "tagtoright";
            params = "0";
          }
        ])
        # Monitor navigation
        ++ (mkSimpleBinds [
          {
            mods = [
              "ALT"
              "SHIFT"
            ];
            key = "Left";
            command = "focusmon";
            params = "left";
          }
          {
            mods = [
              "ALT"
              "SHIFT"
            ];
            key = "Right";
            command = "focusmon";
            params = "right";
          }
          {
            mods = [
              "SUPER"
              "ALT"
            ];
            key = "Left";
            command = "tagmon";
            params = "left";
          }
          {
            mods = [
              "SUPER"
              "ALT"
            ];
            key = "Right";
            command = "tagmon";
            params = "right";
          }
        ])
        # Gaps
        ++ (mkSimpleBinds [
          {
            mods = [
              "ALT"
              "SHIFT"
            ];
            key = "X";
            command = "incgaps";
            params = "1";
          }
          {
            mods = [
              "ALT"
              "SHIFT"
            ];
            key = "Z";
            command = "incgaps";
            params = "-1";
          }
          {
            mods = [
              "ALT"
              "SHIFT"
            ];
            key = "R";
            command = "togglegaps";
          }
        ])
        # Numbered tag bindings
        ++ (mkNumberBinds ["CTRL"] "view" ",0")
        ++ (mkNumberBinds ["ALT"] "tag" ",0")
        # Move/Resize windows
        ++ (mkMoveResizeBinds ["CTRL" "SHIFT"] "movewin")
        ++ (mkMoveResizeBinds ["CTRL" "ALT"] "resizewin");
      description = "Keyboard bindings";
    };

    tagRules = lib.mkOption {
      type = with lib.types;
        listOf (
          attrsOf (oneOf [
            int
            str
          ])
        );
      default =
        builtins.genList (i: {
          id = i + 1;
          layout_name = "tile";
        })
        9;
      description = "Tag-specific rules (layout, monitor assignment, etc.)";
    };

    windowRules = lib.mkOption {
      type = with lib.types;
        listOf (
          attrsOf (oneOf [
            int
            str
            bool
          ])
        );
      default = [];
      description = "Window rules based on appid/title for behavior customization";
    };
  };
}

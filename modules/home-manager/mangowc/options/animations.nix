{lib, ...}: {
  options.mod.programs.mangowc.animations = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable window animations";
    };
    layerAnimationTypeOpen = lib.mkOption {
      type = lib.types.enum ["zoom" "slide" "fade" "none"];
      default = "slide";
      description = "Animation type for opening layers";
    };
    layerAnimationTypeClose = lib.mkOption {
      type = lib.types.enum ["zoom" "slide" "fade" "none"];
      default = "slide";
      description = "Animation type for closing layers";
    };
    zoomInitialRatio = lib.mkOption {
      type = lib.types.float;
      default = 0.3;
      description = "Initial zoom ratio for zoom animations";
    };
    zoomEndRatio = lib.mkOption {
      type = lib.types.float;
      default = 0.8;
      description = "End zoom ratio for zoom animations";
    };
    fadeinBeginOpacity = lib.mkOption {
      type = lib.types.float;
      default = 0.5;
      description = "Beginning opacity for fade-in animations";
    };
    fadeoutBeginOpacity = lib.mkOption {
      type = lib.types.float;
      default = 0.8;
      description = "Beginning opacity for fade-out animations";
    };
    layerAnimations = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable animations for layers (popups, notifications, etc.)";
    };
    openType = lib.mkOption {
      type = lib.types.enum ["zoom" "slide" "fade" "none"];
      default = "slide";
      description = "Animation type for opening windows";
    };
    closeType = lib.mkOption {
      type = lib.types.enum ["zoom" "slide" "fade" "none"];
      default = "slide";
      description = "Animation type for closing windows";
    };
    fadeIn = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable fade-in effect for windows";
    };
    fadeOut = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable fade-out effect for windows";
    };
    tagDirection = lib.mkOption {
      type = lib.types.enum ["horizontal" "vertical"];
      default = "vertical";
      description = "Tag switching animation direction";
    };
    duration = {
      move = lib.mkOption {
        type = lib.types.int;
        default = 500;
        description = "Duration of move animations in milliseconds";
      };
      open = lib.mkOption {
        type = lib.types.int;
        default = 400;
        description = "Duration of window open animations in milliseconds";
      };
      tag = lib.mkOption {
        type = lib.types.int;
        default = 350;
        description = "Duration of tag switch animations in milliseconds";
      };
      close = lib.mkOption {
        type = lib.types.int;
        default = 800;
        description = "Duration of window close animations in milliseconds";
      };
    };
    curve = {
      open = lib.mkOption {
        type = lib.types.str;
        default = "0.46,1.0,0.29,1";
        description = "Bezier curve for window open animations";
      };
      move = lib.mkOption {
        type = lib.types.str;
        default = "0.46,1.0,0.29,1";
        description = "Bezier curve for move animations";
      };
      tag = lib.mkOption {
        type = lib.types.str;
        default = "0.46,1.0,0.29,1";
        description = "Bezier curve for tag switch animations";
      };
      close = lib.mkOption {
        type = lib.types.str;
        default = "0.08,0.92,0,1";
        description = "Bezier curve for window close animations";
      };
    };
  };
}

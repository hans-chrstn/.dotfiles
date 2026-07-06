{lib, ...}: {
  options.mod.programs.mangowc.input = {
    keyboard = {
      repeatRate = lib.mkOption {
        type = lib.types.int;
        default = 25;
        description = "Keyboard repeat rate";
      };
      repeatDelay = lib.mkOption {
        type = lib.types.int;
        default = 600;
        description = "Keyboard repeat delay in milliseconds";
      };
      numlockOn = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable numlock on startup";
      };
      layout = lib.mkOption {
        type = lib.types.str;
        default = "us";
        description = "Keyboard layout (e.g., 'us', 'de', 'fr')";
      };
      rules = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "XKB keyboard mapping rules (usually auto-detected)";
      };
      model = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Keyboard hardware model (e.g., 'pc104', 'macbook')";
      };
      variant = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Keyboard layout variant (e.g., 'dvorak', 'colemak')";
      };
      options = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Additional XKB options (e.g., 'ctrl:nocaps')";
      };
    };
    trackpad = {
      disable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Disable trackpad (requires relogin)";
      };
      tapToClick = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable tap to click (requires relogin)";
      };
      naturalScrolling = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable natural scrolling direction (requires relogin)";
      };
      disableWhileTyping = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Disable trackpad while typing (requires relogin)";
      };
      tapAndDrag = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable tap and drag (requires relogin)";
      };
      dragLock = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable drag lock (requires relogin)";
      };
      leftHanded = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable left-handed mode (requires relogin)";
      };
      middleButtonEmulation = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable middle mouse button emulation (requires relogin)";
      };
      swipeMinThreshold = lib.mkOption {
        type = lib.types.int;
        default = 1;
        description = "Minimum swipe threshold for gestures (requires relogin)";
      };
      accelProfile = lib.mkOption {
        type = lib.types.int;
        default = 2;
        description = "Acceleration profile: 0=none, 1=flat, 2=adaptive (requires relogin)";
      };
      accelSpeed = lib.mkOption {
        type = lib.types.float;
        default = 0.0;
        description = "Acceleration speed from -1.0 to 1.0 (requires relogin)";
      };
      scrollMethod = lib.mkOption {
        type = lib.types.int;
        default = 1;
        description = "Scroll method: 0=none, 1=two-finger, 2=edge, 4=button (requires relogin)";
      };
      clickMethod = lib.mkOption {
        type = lib.types.int;
        default = 1;
        description = "Click method: 0=none, 1=button areas, 2=clickfinger (requires relogin)";
      };
      sendEventsMode = lib.mkOption {
        type = lib.types.int;
        default = 0;
        description = "Send events mode: 0=enabled, 1=disabled, 2=disabled on external mouse (requires relogin)";
      };
      buttonMap = lib.mkOption {
        type = lib.types.int;
        default = 0;
        description = "Finger tap button map: 0=left/right/middle, 1=left/middle/right (requires relogin)";
      };
    };
    mouse = {
      naturalScrolling = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable natural scrolling for mouse (requires relogin)";
      };
    };
    cursor = {
      size = lib.mkOption {
        type = lib.types.int;
        default = 24;
        description = "Cursor size in pixels (requires relogin)";
      };
      theme = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Cursor theme name (requires relogin)";
      };
    };
  };
}

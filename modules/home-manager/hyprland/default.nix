{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.mod.wm.hyprland;
  mod = "SUPER";
in {
  options.mod.wm.hyprland = {
    enable = lib.mkEnableOption "Enable the hyprland feature";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      extraLuaFiles = {
        "hyprsplit/init" = {
          autoLoad = false;
          content = builtins.readFile "${inputs.hyprsplit.packages.${pkgs.system}.hyprsplitlua}/share/hyprsplit/init.lua";
        };
        "hyprload" = {
          autoLoad = true;
          content = ''
            local hs = require("hyprsplit")
            hs.config({ num_workspaces = 10 })
            for i = 1, 10 do
                local key = i % 10 -- 10 maps to key 0
                hl.bind("SUPER + " .. key, hs.dsp.focus({ workspace = i }))
                hl.bind("SUPER + SHIFT + " .. key, hs.dsp.window.move({ workspace = i, follow = false }))
            end

            hl.bind("SUPER + " .. "g", hs.dsp.grab_rogue_windows())
            hl.bind("SUPER + " .. "d", hs.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "+1" }))
          '';
        };
      };
      settings = {
        bind = [
        ];
      };
    };
  };
}

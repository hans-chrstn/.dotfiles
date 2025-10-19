{ inputs, lib, pkgs, config, ... }:
let
 cfg = config.mod.programs.zen;
in
{
  options.mod.programs.zen = {
    enable = lib.mkEnableOption "Enable zen";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      inputs.zen-browser.packages."${pkgs.system}".twilight
    ];
  };
}


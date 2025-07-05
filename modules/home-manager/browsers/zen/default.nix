{ inputs, lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.zen;
in
{
  options.mod.zen = {
    enable = mkEnableOption "Enable zen";
  };

  config = mkIf cfg.enable {
    home.packages = [
      inputs.zen-browser.packages."${pkgs.system}".twilight
    ];
  };
}


{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.dotfiles.gaming.minecraft;
in {
  options.dotfiles.gaming.minecraft = {
    enable = lib.mkEnableOption "Enable minecraft config and it's best values";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (prismlauncher.override {
        jdks = [
          graalvmPackages.graalvm-ce
          zulu8
          zulu17
          zulu
        ];
      })
    ];
  };
}

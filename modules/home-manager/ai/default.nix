{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.mod.programs.ai;
in {
  options.mod.programs.ai = {
    enableGemini = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Gemini";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enableGemini {
      home.packages = with pkgs; [gemini-cli];
    })
  ];
}

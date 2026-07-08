{lib}: {
  name,
  category ? "programs",
  description ? "Enable ${name}",
  extraOptions ? {},
  configFunc,
  args,
}: let
  cfg = args.config.mod.${category}.${name};
in {
  options.mod.${category}.${name} =
    {
      enable = lib.mkEnableOption description;
    }
    // extraOptions;

  config = lib.mkIf cfg.enable (configFunc args cfg);
}

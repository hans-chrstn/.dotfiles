{ inputs, lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.spicetify;
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  options.mod.spicetify = {
    enable = mkEnableOption "Enable spicetify config and it's best values";
  };

  config = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system}; #.default
  in
  mkIf cfg.enable {

    # import the flake's module for your system

    # configure spicetify :)
    programs.spicetify = {
      enable = true;
      #theme = spicePkgs.themes.Bloom;
      #colorScheme = "dark";

      enabledCustomApps = with spicePkgs.apps; [
        marketplace
        localFiles
      ];

      enabledExtensions = with spicePkgs.extensions; [
      ];    
    };
  };
}

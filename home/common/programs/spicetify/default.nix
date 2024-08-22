{ pkgs, lib, inputs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system}; #.default
in
{

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "spotify"
  ];

  # import the flake's module for your system
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  # configure spicetify :)
  programs.spicetify =
    {
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
}

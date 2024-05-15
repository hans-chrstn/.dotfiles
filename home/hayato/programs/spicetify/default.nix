{ pkgs, lib, inputs, outputs, ... }:
let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "spotify"
  ];

  # import the flake's module for your system
  imports = [ inputs.spicetify-nix.homeManagerModule ];

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

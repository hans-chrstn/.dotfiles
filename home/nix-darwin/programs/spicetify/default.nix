{ pkgs, lib, inputs, ...}:
let
  spicePkgs = inputs.spicetify-nix-darwin.packages.${pkgs.system}.default;
in {

  imports = [
    inputs.spicetify-nix-darwin.homeManagerModule
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "spotify"
  ];

  programs.spicetify = {
    enable = true;
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];
    enabledExtensions = with spicePkgs.extensions; [
    ];
  };

}

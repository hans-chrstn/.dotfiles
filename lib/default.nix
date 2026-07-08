{
  inputs,
  root,
}: let
  inherit (inputs.nixpkgs) lib;

  systems = [
    "aarch64-linux"
    "i686-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];

  forAllSystems = f: lib.genAttrs systems f;

  modules = import (root + "/modules");
  overlays = (import (root + "/overlays")) {inherit inputs lib;};
  customPackagesOverlay = final: prev:
    (import (root + "/packages")) {
      pkgs = final;
      lib = prev.lib;
    };

  mkModule = import ./mkModule.nix {inherit lib;};

  mkNixosHost = hostname: hostConfig:
    lib.nixosSystem {
      specialArgs = {
        inherit inputs mkModule;
        modules = modules.nixos;
      };
      modules =
        [
          {nixpkgs.hostPlatform = hostConfig.arch;}
          {
            nixpkgs.overlays =
              overlays
              ++ [
                customPackagesOverlay
                inputs.dotstylix.overlays.default
              ];
          }
          (root + "/hosts/${hostname}")
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs mkModule;
                modules = modules.home-manager;
              };
              users."${hostname}" = {
                imports =
                  [
                    (root + "/users/${hostname}")
                    inputs.dotstylix.homeModules.default
                  ]
                  ++ builtins.attrValues modules.home-manager;
              };
            };
          }
        ]
        ++ builtins.attrValues modules.nixos;
    };

  mkDarwinHost = hostname: hostConfig:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit inputs mkModule;
        modules = modules.nixos;
      };
      modules =
        [
          {nixpkgs.hostPlatform = hostConfig.arch;}
          {
            nixpkgs.overlays = overlays ++ [customPackagesOverlay];
            nixpkgs.config.allowUnfree = true;
          }
          (root + "/hosts/${hostname}")
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs mkModule;
                modules = modules.home-manager;
              };
              users."${hostname}" = {
                imports =
                  [
                    (root + "/users/${hostname}")
                    inputs.dotstylix.homeModules.default
                  ]
                  ++ builtins.attrValues modules.home-manager;
              };
            };
          }
        ]
        ++ builtins.attrValues modules.nixos;
    };
in {
  inherit systems forAllSystems mkNixosHost mkDarwinHost;
}

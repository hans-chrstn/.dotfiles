{
  inputs,
  metadata,
  root,
}: let
  inherit (inputs.nixpkgs) lib;
  systems = lib.unique (map (host: host.system) (builtins.attrValues metadata));
  forAllSystems = lib.genAttrs systems;
  modules = import (root + "/modules");
  overlays = import (root + "/overlays") {inherit inputs lib;};
  overlayRegistry = {
    inherit (overlays) nvidia proxmox;
  };
  mkNixosHost = name: host:
    lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        hostConfig = host;
      };

      modules =
        [
          inputs.home-manager.nixosModules.home-manager
          {
            nixpkgs.hostPlatform = host.system;
            nixpkgs.overlays =
              [
                overlays.default
                inputs.dotstylix.overlays.default
              ]
              ++ map (overlay: overlayRegistry.${overlay}) host.overlays;

            networking.hostName = host.hostName;
            dotfiles.primaryUser = host.username;
            dotfiles.nix.privateCache.enable = host.privateCache;

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs;};
              sharedModules = modules.home;
              users.${host.username}.imports = [
                (root + "/users/${host.username}")
                inputs.dotstylix.homeModules.default
              ];
            };
          }
          (root + "/hosts/${name}")
        ]
        ++ modules.nixos
        ++ host.profiles;
    };
in {
  inherit forAllSystems mkNixosHost modules overlays systems;
}

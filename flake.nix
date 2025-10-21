{
  description = "A NixOS Flake Template";

  nixConfig = {
    trusted-public-keys = [
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    substituers = [
      "https://niri.cachix.org"
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks-nix = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ---HOST-SPECIFICS---
    nvidia-patch = {
      url = "github:icewind1991/nvidia-patch-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    proxmox-nixos.url = "github:SaumonNet/proxmox-nixos";

    dotnixvim = {
      url = "github:hans-chrstn/.nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.follows = "dotnixvim/nixvim";

    dotstylix = {
      url = "github:hans-chrstn/.stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.follows = "dotstylix/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-darwin,
    nixos-wsl,
    sops-nix,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    forAllSystems = f: lib.genAttrs systems f;
    allHosts = lib.mapAttrs (hostname: _: import ./hosts/${hostname}/system.nix) (
      lib.filterAttrs (name: _: name != ".gitkeep") (builtins.readDir ./hosts)
    );
    nixosHosts =
      lib.filterAttrs (
        hostname: hostConfig: hostConfig.type == "nixos" || hostConfig.type == "wsl"
      )
      allHosts;
    darwinHosts = lib.filterAttrs (hostname: hostConfig: hostConfig.type == "darwin") allHosts;

    modules = import ./modules;
    overlays = (import ./overlays) {
      inherit inputs;
      lib = nixpkgs.lib;
    };
    customPackagesOverlay = final: prev:
      (import ./packages) {
        pkgs = final;
        lib = prev.lib;
      };
  in {
    nixosConfigurations =
      lib.mapAttrs (
        hostname: hostConfig:
          lib.nixosSystem {
            system = hostConfig.arch;
            specialArgs = {inherit inputs modules;};
            modules = [
              modules.nixos.common-universal
              modules.nixos.common-linux
              {nixpkgs.overlays = overlays ++ [customPackagesOverlay inputs.dotstylix.overlays.default];}
              ./hosts/${hostname}

              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users."${hostname}" = import ./users/${hostname}/home.nix;
                  extraSpecialArgs = {inherit inputs modules;};
                };
              }
            ];
          }
      )
      nixosHosts;

    darwinConfigurations =
      lib.mapAttrs (
        hostname: hostConfig:
          nix-darwin.lib.darwinSystem {
            system = hostConfig.arch;
            specialArgs = {inherit inputs modules;};
            modules = [
              {nixpkgs.overlays = overlays ++ [customPackagesOverlay];}
              ./hosts/${hostname}
              home-manager.darwinModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users."${hostname}" = import ./users/${hostname}/home.nix;
                  extraSpecialArgs = {inherit inputs;};
                };
              }
            ];
          }
      )
      darwinHosts;

    devShells = forAllSystems (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        default = pkgs.mkShell {
          packages = with pkgs; [
            git
            alejandra
            sops
            pre-commit
            direnv
          ];
        };
      }
    );

    checks = forAllSystems (system: {
      pre-commit-check = inputs.pre-commit-hooks-nix.lib.${system}.run {
        src = self;
        hooks = {
          alejandra.enable = true;
        };
      };
    });

    apps = forAllSystems (system: {
      new-machine = {
        type = "app";
        program = "${self}/scripts/new-machine.sh";
      };

      new-module = {
        type = "app";
        program = "${self}/scripts/new-module.sh";
      };

      new-overlay = {
        type = "app";
        program = "${self}/scripts/new-overlay.sh";
      };

      new-package = {
        type = "app";
        program = "${self}/scripts/new-package.sh";
      };

      setup = {
        type = "app";
        program = "${self}/scripts/setup.sh";
      };
    });
  };
}

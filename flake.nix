{
  description = "Flake by Mishima";

  nixConfig = {
    trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "proxmox-nixos:nveXDuVVhFDRFx8Dn19f1WDEaNRJjPrF2CPD2D+m1ys="
    ];
    substituers = [
      "https://cache.garnix.io"
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://cache.saumon.network/proxmox-nixos"
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    proxmox-nixos.url = "github:SaumonNet/proxmox-nixos";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix"; 
    };

    spicetify-nix-darwin.url = "github:Believer1/spicetify-nix";

    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprsysteminfo = {
      url = "github:hyprwm/hyprsysteminfo";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-darwin,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib // nix-darwin.lib;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    forAllSystems = lib.genAttrs systems;

    mkSystemConfig = let
      configMap = {
        nixos = lib.nixosSystem;
        darwin = lib.darwinSystem;
      };
    in {
      userName ? "nixos",
      system ? "x86_64-linux",
      configType ? "nixos",
      homeManager ? false,
      specialArgs ? {},
      specialHomeArgs ? {},
      extraModules ? [],
    }:
      (configMap.${configType}) {
        specialArgs = { inherit inputs outputs; } // specialArgs;
        system = system;
        modules = extraModules ++ (
          if homeManager == true then [
            home-manager.nixosModules.home-manager {
              home-manager = {
                useUserPackages = true;
                users.${userName} = import ./home/users/${userName};
                extraSpecialArgs = { inherit inputs outputs; } // specialHomeArgs;
              };
            }
          ] else []
        ) ++ [ ./hosts/users/${userName} ./hosts/hardware/${userName}.nix ];
      };
  in {
    packages = forAllSystems (pkgs: import ./pkgs {inherit pkgs;});
    formatter = forAllSystems (pkgs: pkgs.alejandra);
    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    darwinConfigurations = {
      # HACKINTOSH
      "nix-darwin" = mkSystemConfig {
        system = "x86_64-darwin";
        userName = "nix-darwin";
        homeManager = true;
      };
    };

    nixosConfigurations = {
      # PERSONAL LAPTOP
      hayato = mkSystemConfig {
        userName = "hayato";
        homeManager = true;

      };

      masato = mkSystemConfig {
        userName = "masato";
        homeManager = true;
      };

      # MAIN DESKTOP
      mishima = mkSystemConfig {
        userName = "mishima";
        homeManager = true;
      };

      # WSL
      toru = mkSystemConfig {
        userName = "toru";
        homeManager = true;
      };
    };
  };
}

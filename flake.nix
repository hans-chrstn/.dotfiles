{
  description = "A NixOS Flake Template";

  nixConfig = {
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    substituers = [
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

    dotstylix = {
      url = "github:hans-chrstn/.stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.follows = "dotstylix/stylix";

    dotnvim = {
      url = "github:hans-chrstn/.nvim";
      flake = false;
    };

    hyprland = {
      url = "github:hyprwm/hyprland";
    };

    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      inputs.hyprland.follows = "hyprland";
    };

    hyprexpo = {
      url = "github:sandwichfarm/hyprexpo";
      flake = false;
    };

    dotquickshell = {
      url = "github:hans-chrstn/.quickshell/pulse";
    };
    quickshell.follows = "dotquickshell/quickshell";
    qml-niri.follows = "dotquickshell/qml-niri";

    crab = {
      url = "path:/home/jin/Projects/Crab";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    utils = import ./lib {
      inherit inputs;
      root = ./.;
    };

    allHosts = lib.mapAttrs (hostname: _: import ./hosts/${hostname}/system.nix) (
      lib.filterAttrs (name: _: name != ".gitkeep") (builtins.readDir ./hosts)
    );

    nixosHosts = lib.filterAttrs (_: c: c.type == "nixos" || c.type == "wsl") allHosts;
    darwinHosts = lib.filterAttrs (_: c: c.type == "darwin") allHosts;
  in {
    nixosConfigurations = lib.mapAttrs utils.mkNixosHost nixosHosts;
    darwinConfigurations = lib.mapAttrs utils.mkDarwinHost darwinHosts;

    devShells = utils.forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      default = pkgs.mkShell {
        packages = with pkgs; [git alejandra sops pre-commit direnv];
      };
    });

    checks = utils.forAllSystems (system: {
      pre-commit-check = inputs.pre-commit-hooks-nix.lib.${system}.run {
        src = self;
        hooks = {alejandra.enable = true;};
      };
    });

    apps = utils.forAllSystems (system: {
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

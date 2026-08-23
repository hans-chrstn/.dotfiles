{
  description = "NixOS systems and user environments";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    wolf = {
      url = "github:altano/flakes?dir=wolf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

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

    nvidia-patch = {
      url = "github:icewind1991/nvidia-patch-nixos";
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

    hyprland.url = "github:hyprwm/hyprland";

    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      inputs.hyprland.follows = "hyprland";
    };

    hyprexpo = {
      url = "github:sandwichfarm/hyprexpo";
      flake = false;
    };

    dotquickshell.url = "github:hans-chrstn/.quickshell/pulse";
    quickshell.follows = "dotquickshell/quickshell";
    crab.url = "github:hans-chrstn/Crab";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    lib = nixpkgs.lib;
    metadata = import ./hosts;
    utils = import ./lib {
      inherit inputs metadata;
      root = ./.;
    };
    inherit (utils) forAllSystems modules overlays;
  in {
    nixosConfigurations = lib.mapAttrs utils.mkNixosHost metadata;

    nixosModules.default = {imports = modules.nixos;};
    homeModules.default = {imports = modules.home;};
    inherit overlays;

    packages = forAllSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [overlays.default];
      };
    in
      import ./packages {
        inherit pkgs;
        inherit (pkgs) lib;
      });

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShell {
        packages = with pkgs; [
          alejandra
          attic-client
          deadnix
          direnv
          git
          pre-commit
          shellcheck
          sops
          statix
        ];
      };
    });

    checks = forAllSystems (system: {
      pre-commit = inputs.pre-commit-hooks-nix.lib.${system}.run {
        src = self;
        hooks = {
          alejandra.enable = true;
          deadnix.enable = true;
          shellcheck = {
            enable = true;
            excludes = ["^\\.envrc$"];
          };
        };
      };
    });

    apps = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      mkApp = name: description: runtimeInputs: {
        type = "app";
        program = lib.getExe (pkgs.writeShellApplication {
          inherit name runtimeInputs;
          text = ''exec ${self}/scripts/${name}.sh "$@"'';
        });
        meta.description = description;
      };
      commonInputs = [pkgs.coreutils pkgs.git pkgs.gnugrep pkgs.gnused];
    in {
      new-machine = mkApp "new-machine" "Scaffold a host and its metadata" (commonInputs ++ [pkgs.alejandra]);
      new-module = mkApp "new-module" "Scaffold and register a module" (commonInputs ++ [pkgs.alejandra]);
      new-overlay = mkApp "new-overlay" "Scaffold and register an overlay" (commonInputs ++ [pkgs.alejandra]);
      new-package = mkApp "new-package" "Scaffold and register a package" (commonInputs ++ [pkgs.alejandra]);
      setup = mkApp "setup" "Install repository development hooks" (commonInputs ++ [pkgs.direnv pkgs.pre-commit]);
      scaffold = mkApp "scaffold" "Create a repository resource" (commonInputs ++ [pkgs.alejandra]);
      remove = mkApp "remove" "Safely remove a repository resource" (commonInputs ++ [pkgs.ripgrep pkgs.nix]);
    });
  };
}

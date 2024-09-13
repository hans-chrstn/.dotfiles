{
  description = "Flake by Mishima";

  nixConfig = {
    trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    substituers = [
      "https://cache.garnix.io"
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
  };

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    wezterm = {
      url = "github:wez/wezterm/main?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi = {
      url = "github:sxyazi/yazi";
    };

    zen-browser = {
      url = "github:MarceColl/zen-browser-flake";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-snapd = {
      url = "github:io12/nix-snapd";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix"; 
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix-darwin = {
      url = "github:Believer1/spicetify-nix";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
    };

    ags-v2 = {
      url = "github:Aylur/ags/v2";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    prismlauncher = {
      url = "github:julcioo/PrismLauncher-Cracked";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };
 
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };   

    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        hyprutils.follows = "hyprland/hyprutils";
        nixpkgs.follows = "hyprland/nixpkgs";
        systems.follows = "hyprland/systems";
      };
    };

    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      inputs.hyprland.follows = "hyprland";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-darwin,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);


    # without forAllSystems
    # use this link: https://github.com/vimjoyer/devshells-video credits to vimjoyer
    # otherwise:
    # devShells = forAllSystems (system: let
    #   pkgs = import nixpkgs { inherit system; };
    # in {
    #   default = pkgs.mkShell {
    #     nativeBuildInputs = with pkgs; [
    #       cowsay
    #     ];
    #   };
    #   java = pkgs.mkShell {
    #     nativeBuildInputs = with pkgs; [ gcc ncurses patchelf maven gradle zlib jdk ];
    #   };
    #
    #   python = pkgs.mkShell {
    #     nativeBuildInputs = with pkgs; [ (python3.withPackages(ps: with ps; [ pip tkinter debugpy requests psutil ]))];
    #   };
    #
    #   js = pkgs.mkShell {
    #     nativeBuildInputs = with pkgs; [ nodejs nodePackages.sass typescript bun sassc ];
    #   };
    #
    #   clang = pkgs.mkShell {
    #     nativeBuildInputs = with pkgs; [ clang-tools clang cl cmake ];
    #   };
    #
    #   lua = pkgs.mkShell {
    #     nativeBuildInputs = with pkgs; [ (lua.withPackages(ls: with ls; [ luarocks ])) luajit ];
    #   };
    # });

    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    darwinConfigurations = {
      "nix-darwin" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [ ./hosts/nix-darwin/default.nix ];
      };
    };

    nixosConfigurations = {
      hayato = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [ ./hosts/hayato/default.nix ];
      };

      mishima = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [ ./hosts/mishima/default.nix ];
      };
    };

    homeConfigurations = {
      hayato = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [ ./home/hayato/default.nix ];
      };

      mishima = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [ ./home/mishima/default.nix ];
      };

      "nix-darwin" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-darwin;
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [ ./home/nix-darwin/default.nix ];
      };
    };
  };
}

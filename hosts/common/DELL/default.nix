{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    ./programs.nix 
    ./filesystem
    ./hardware-configuration.nix
    ./network
    ./hardware
    ./services
    ./drivers
    ./core
    ./virtualization
    ./users
  ];

  # REMOVES UNNECESSARY PREINSTALLED PKGS
  environment = {
    defaultPackages = lib.mkForce [];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  services.xserver.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}

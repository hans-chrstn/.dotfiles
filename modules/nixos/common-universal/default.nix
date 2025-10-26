{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
# NOTE: You probably don't want to mess with this
# Every setting here can be overwritten in your host/user config
# using foo = lib.mkForce val;
{
  nixpkgs.config.allowUnfree = true;
  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  time.timeZone = "America/New_York";
  system.stateVersion = "25.11";
}

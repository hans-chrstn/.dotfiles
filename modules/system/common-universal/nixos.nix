{
  lib,
  config,
  inputs,
  ...
}:
# NOTE: You probably don't want to mess with this
# Every setting here can be overwritten in your host/user config
# using foo = lib.mkForce val;
{
  options.dotfiles = {
    primaryUser = lib.mkOption {
      type = lib.types.str;
      description = "Primary Home Manager user";
    };

    nix.privateCache.enable = lib.mkEnableOption "the private binary cache";
  };

  config = {
    nixpkgs.config.allowUnfree = true;
    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        nix-path = config.nix.nixPath;
        substituters =
          [
            "https://cache.nixos.org"
            "https://nix-community.cachix.org"
          ]
          ++ lib.optionals config.dotfiles.nix.privateCache.enable ["https://cache.hestallo.com/homelab"];
        trusted-public-keys =
          [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          ]
          ++ lib.optionals config.dotfiles.nix.privateCache.enable ["homelab:GvRS8Og7LYDKOL0sV2SfH2OIvwMAbGiqOj/yMh62HWc="];
      };
      channel.enable = false;

      registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

    time.timeZone = "America/New_York";
    system.stateVersion = "26.11";
  };
}

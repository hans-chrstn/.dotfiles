{
  lib,
  pkgs,
}:
lib.genAttrs (import ./registry.nix) (name: pkgs.callPackage ./${name} {})

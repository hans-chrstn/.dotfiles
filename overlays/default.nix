{inputs, lib}: let
  dirContents = builtins.readDir ./.;
  overlayFiles = lib.filterAttrs (name: type: name != "default.nix" && type == "regular") dirContents;
in
  lib.mapAttrsToList (name: _: import ./${name} { inherit inputs; }) overlayFiles

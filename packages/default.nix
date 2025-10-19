{pkgs, lib}: let
  dirContents = builtins.readDir ./.;
  packageDirs = lib.filterAttrs (name: type: type == "directory") dirContents;
in
  lib.mapAttrs (name: _: pkgs.callPackage ./${name} { }) packageDirs

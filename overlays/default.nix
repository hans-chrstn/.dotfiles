{
  inputs,
  lib,
}: let
  additions = final: prev:
    import ../packages {
      pkgs = final;
      lib = prev.lib;
    };
  local = lib.genAttrs (import ./registry.nix) (name: import ./${name}.nix);
  nvidia = inputs.nvidia-patch.overlays.default;
  proxmox = inputs.proxmox-nixos.overlays."x86_64-linux";
in
  local
  // {
    inherit additions nvidia proxmox;
    default = lib.composeManyExtensions ([additions] ++ builtins.attrValues local);
  }

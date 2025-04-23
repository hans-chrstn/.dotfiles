{ config, outputs, ... }:
{
  imports = [
    ../../common/toru.nix
    ./overlays.nix
  ] ++ (builtins.attrValues outputs.nixosModules);
}

{ config, outputs, ... }:
{
  imports = [
    ../../common/toru.nix
    ./overlays.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  programs.virtualise.enable = true;
}

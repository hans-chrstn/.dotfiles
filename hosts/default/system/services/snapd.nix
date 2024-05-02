{ inputs, ...}:
{
  imports = [
    inputs.nix-snapd.nixosModules.default
  ];
  
  services.snap.enable = true;
  
}

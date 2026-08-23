{
  name = "jin";
  system = "x86_64-linux";
  username = "jin";
  hostName = "nixos-main";
  profiles = [
    ../../profiles/gaming.nix
    ../../profiles/workstation.nix
  ];
  overlays = [];
  privateCache = true;
}

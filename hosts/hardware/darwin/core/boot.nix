{ ... }:
{
  services.nix-daemon.enable = true;


  # For Flakes
  nix.settings = {
    experimental-features = "nix-command flakes";
    allowed-users = [ "nix-darwin" "root" ];
    trusted-users = [ "nix-darwin" "root" ];
  };

  system = {
    configurationRevision = null;
    stateVersion = 4;
  };
  
  nixpkgs = {
    hostPlatform = "x86_64-darwin";
    config = {
      allowUnfree = true; 
    };
  };
}

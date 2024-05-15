{ ... }:
{
  nix = {
#    optimise = {
#      automatic = true;
#      interval = "weekly";
#    };

#    gc = {
#      automatic = true;
#      interval = "weekly";
#      options = "--delete-older-than 7d";
#    };
    
    settings = {
      auto-optimise-store = true;
      cores = 4;
      max-jobs = 4;
      trusted-substituters = [
        "https://cache.nixos.org"
      ];
    };
  };
}

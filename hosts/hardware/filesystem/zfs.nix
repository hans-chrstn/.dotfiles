{ pkgs, ... }:
{
  boot.zfs = {
    extraPools = [ "tank" ];
  };

  services.zfs = {
    autoScrub = {
      enable = true;
      pools = [ "tank" ];
    };
    autoSnapshot = {
      enable = true;
    };
  };

  networking.hostId = "fffafb21"; #temp just to test zfs

  environment.systemPackages = with pkgs; [ zfs ];
  boot.supportedFilesystems = ["zfs"];
  boot.kernelModules = ["zfs"];
}

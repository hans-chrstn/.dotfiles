{ pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";

    rootless = {
      setSocketVariable = true;
      enable = true;
    };
  };
  environment.systemPackages = with pkgs; [ docker-compose ];
}

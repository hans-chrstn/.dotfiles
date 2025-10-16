{ pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    storageDriver = "overlay2";
    extraOptions = ''
      --data-root /tank/data/docker/root
    '';
  };
  environment.systemPackages = with pkgs; [ docker-compose ];

  hardware.nvidia-container-toolkit.enable = true;
}

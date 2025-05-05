{ pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
  };
  environment.systemPackages = with pkgs; [ docker-compose ];

  hardware.nvidia-container-toolkit.enable = true;
}

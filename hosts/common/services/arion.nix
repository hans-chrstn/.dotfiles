{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    arion
  ];

  virtualisation = {
    docker.enable = false;
    podman = {
      enable = true;
      enableNvidia = true;
      dockerSocket.enable = true;
      dockerCompat = true;
      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
  };
  environment.sessionVariables = {
    DOCKER_HOST = "unix:///run/podman/podman.sock";
  };
}

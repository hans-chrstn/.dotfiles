{ pkgs, ... }:
{
  services.nfs.server = {
    enable = true;
  };

  networking.firewall.allowedTCPPorts = [
    2049
  ];

  environment.systemPackages = with pkgs; [ nfs-utils ];
}

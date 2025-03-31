{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clamav
  ];
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
    scanner = {
      enable = true;
      scanDirectories = [
        "/docker-root"
        "/cloud"
        "/home"
      ];
    };
  };
}

{ pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [ 19999 ];
  services.netdata = {
    package = pkgs.netdata.override {
      withCloudUi = true;
    };
    enable = true;
    config = {
      global = {
        "debug log" = "syslog";
        "access log" = "syslog";
        "error log" = "syslog";
      };
    };
  };

  systemd.services.netdata.path = [pkgs.linuxPackages.nvidia_x11_beta];
  services.netdata.configDir."python.d.conf" = pkgs.writeText "python.d.conf" ''
    nvidia_smi: yes
  '';
}

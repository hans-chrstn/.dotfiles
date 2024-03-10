{ lib, pkgs, ... }:

{
  networking.hostName = "nixos";
  
  networking = {
    networkmanager = {
      enable = true;
    };
  };

  services.resolved = {
    enable = true;
    extraConfig = ''
      [Resolve]
      DNS=45.90.28.0#5647dd.dns.nextdns.io
      DNS=2a07:a8c0::#5647dd.dns.nextdns.io
      DNS=45.90.30.0#5647dd.dns.nextdns.io
      DNS=2a07:a8c1::#5647dd.dns.nextdns.io
      DNSOverTLS=yes
    '';

  };
  
  
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  security.polkit.enable = true;

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
  
  systemd.services.networkManagerRestart = {
    description = "Restart NetworkManger.service every reboot";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.networkmanager}/bin/NetworkManager restart";
      Restart = "always";
    };
  };


  # Don't wait for network startup
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}

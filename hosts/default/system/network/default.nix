{ lib, pkgs, ... }:

{
  networking = {
    hostName = "nixos";  # DISCOVERABLE NETWORK NAME
    nameservers = [
      #nextdns
#      "45.90.28.0#25f5a7.dns.nextdns.io"
#      "2a07:a8c0::#25f5a7.dns.nextdns.io"
#      "45.90.30.0#25f5a7.dns.nextdns.io"
#      "2a07:a8c1::#25f5a7.dns.nextdns.io"
      #quad9
      "9.9.9.9"
      "149.112.112.112"
      "2620:fe::fe"
      "2620:fe::9"
      #cloudflare
      "1.1.1.1"
      "2606:4700:4700::1111"
      "1.0.0.1"
      "2606:4700:4700::1001"

    ]; 
    networkmanager = {
      enable = true;
    };
  };

#      [Resolve]
#      DNS=45.90.28.0#25f5a7.dns.nextdns.io
#      DNS=2a07:a8c0::#25f5a7.dns.nextdns.io
#      DNS=45.90.30.0#25f5a7.dns.nextdns.io
#      DNS=2a07:a8c1::#25f5a7.dns.nextdns.io
#      DNSOverTLS=yes
#      MulticastDNS=resolve

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    extraConfig = ''
      DNSOverTLS=yes
      MulticastDNS=resolve
    '';
    llmnr = "true";
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
  
#   systemd.services.networkManagerRestart = {
#    description = "Restart NetworkManger.service every reboot";
#    wantedBy = [ "multi-user.target" ];
#    wants = [ "multi-user.target" ];
#    after = [ "multi-user.target" ];
#    serviceConfig = {
#      Type = "simple";
#      ExecStart = "${pkgs.networkmanager}/bin/NetworkManager";
#      Restart = "always";
#      RestartSec = "5";
#    };
#  };


  # Don't wait for network startup
#  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}

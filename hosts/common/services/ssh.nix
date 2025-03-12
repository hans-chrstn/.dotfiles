{ lib, ... }:
{

  programs.ssh.startAgent = true;
  services.fail2ban = {
    enable = true;
    jails = {
      sshd.settings = {
        enabled = true;
        port = "ssh";
        filter = "sshd";
        logpath = "/var/log/auth.log";
        maxretry = 5;
        bantime = "24h";
      };
    };
  };
  services.openssh = {
    enable = true; #true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      X11Forwarding = false;
      X11UseLocalhost = true;
      PubkeyAuthentication = true;
    };
  };

}

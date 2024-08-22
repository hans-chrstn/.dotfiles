{ lib, ... }:
{

  systemd.services.sshd.wantedBy = lib.mkForce [];

  programs.ssh.startAgent = true;

  services.openssh = {
    enable = true; #true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = false;
    };
  };

}

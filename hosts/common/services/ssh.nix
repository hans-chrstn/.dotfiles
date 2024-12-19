{ lib, ... }:
{

  programs.ssh.startAgent = true;
  services.openssh = {
    enable = true; #true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      PasswordAuthentication = true;
      X11Forwarding = true;
      X11UseLocalhost = false;
    };
  };

}

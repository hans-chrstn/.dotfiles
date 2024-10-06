{ pkgs, ... }:
{
  services = {
    samba = {
      enable = true;
      openFirewall = true;
      package = pkgs.samba4Full;
/*       extraConfig = ''
        server smb encrypt = required
        # ^^ Note: Breaks `smbclient -L <ip/host> -U%` by default, might require the client to set `client min protocol`?
        server min protocol = SMB3_00
      ''; */

      settings = {
        homes = {
          browseable = "no";
          "read only" = "no";
          "guest ok" = "no";
        };
      };
    };

    avahi = {
      publish.enable = true;
      publish.userServices = true;
      # ^^ Needed to allow samba to automatically register mDNS records (without the need for an `extraServiceFile`
      nssmdns4 = true;
      # ^^ Not one hundred percent sure if this is needed- if it aint broke, don't fix it
	    enable = true;
      openFirewall = true;
    };

    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
  };
}

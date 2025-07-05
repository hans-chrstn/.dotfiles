{ ... }:

{
  # ENABLES THE PRINTING SERVICE
  services.printing.enable = true;
  services.avahi = {
   enable = true;
   nssmdns4 = true;
   openFirewall = true;
  };

}

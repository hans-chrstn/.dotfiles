{ ... }:
{
  services.avahi = {
    publish = {
      enable = true;
      userServices = true;
    };
  };
}

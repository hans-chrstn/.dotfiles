{ lib, ... }:
{
  swapDevices = [
#    {
#      device = lib.mkForce "/swap";
#      size = 1024*8;
#      label = "swap";
#    }
  ];
  
  zramSwap = {
    enable = true;
  };
}

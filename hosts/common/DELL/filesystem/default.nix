{ lib, ... }:
{
  # THIS PART IS A SWAPFILE NOT A PARTITION. YOU CAN CREATE A SWAP FILE USING DD
  swapDevices = [
    {
      device = lib.mkForce "/swap";
      size = 1024*8;
      label = "swap";
    }
  ];
  
  # STORES COMPRESSED MEMORY IN RAM, PROVIDING EFFICIENT USAGE OF MEMORY
  zramSwap = {
    enable = true;
  };
}

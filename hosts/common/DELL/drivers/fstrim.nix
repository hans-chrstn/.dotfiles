{ ... }:

{
  /*
    BE CAREFUL IN USING THIS, ONLY WORKS IN MODERN SSD's THAT SUPPORT IT. 
    OTHERWISE, MIGHT RESULT IN DATE CORRUPTION OR LOSS
  */  
  services.fstrim.enable = true;

}

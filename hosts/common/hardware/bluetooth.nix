{ ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        ControllerMode = "dual";
        FastConnectable = true;
        Experimental = true;
      };
    };
  };
  
  services.blueman.enable = true;

}

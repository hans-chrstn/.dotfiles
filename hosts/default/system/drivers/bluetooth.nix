{ pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };

  };
#  systemd.user.services.mpris-proxy = {
#    description = "Mpris proxy";
#    after = [ "network.target" "sound.target" ];
#    wantedBy = [ "default.target" ];
#    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
#  };


}

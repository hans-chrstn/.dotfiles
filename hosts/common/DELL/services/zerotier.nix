{ ... }:
{
  services.zerotierone = {
    enable = true;
    localConf = {
      settings = {
        softwareUpdate = "disable";
      };
    };
  };
}

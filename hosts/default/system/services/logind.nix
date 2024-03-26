{ ... }:

{
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };
}

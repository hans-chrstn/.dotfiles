{ ... }:

{
  # BASICALLY JUST THE POWERBUTTON OR THE LID CLOSING ON LAPTOP
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
    powerKeyLongPress = "poweroff";
    powerKey = "hibernate";
  };
}

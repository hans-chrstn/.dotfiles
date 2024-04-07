{ ... }:

{
  services = {
    gvfs.enable = true;
    gnome = {
      sushi.enable = true;
      gnome-keyring.enable = true;
    };
    dbus = {
      enable = true;
      implementation = "dbus";
    };
  };



}

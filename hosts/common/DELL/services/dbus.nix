{ pkgs, ... }:

{

  programs.dconf.enable = true;

  services = {
    gvfs.enable = true;
    #gnome = {
    #  sushi.enable = true;
    #  gnome-keyring.enable = true;
    #};
    dbus = {
      packages = with pkgs; [dconf];
      enable = true;
      implementation = "dbus";
    };
  };



}

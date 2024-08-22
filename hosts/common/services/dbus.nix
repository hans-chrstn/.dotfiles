{ pkgs, ... }:

{

  programs.dconf.enable = true;

  services = {
    gvfs.enable = true;
    dbus = {
      packages = with pkgs; [dconf];
      enable = true;
      implementation = "dbus";
    };
  };



}

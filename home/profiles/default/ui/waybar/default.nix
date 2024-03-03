{ config, lib, pkgs, ... }:

{
  programs.waybar = {
      enable = true;
      systemd = {
        enable = false;
        target = "graphical-session.target";
      };
 };
}

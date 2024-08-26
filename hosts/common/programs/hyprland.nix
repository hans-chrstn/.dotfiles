{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
  };

  security = {
    pam.services = {
      hyprlock.text = ''
        auth include login
      '';
      ags = {};
    };
  };
}

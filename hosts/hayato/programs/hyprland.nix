{ ... }:
{
  programs.hyprland = {
    enable = true;
  };

  security = {
    pam.services.hyprlock.text = ''
      auth include login
    '';
  };
}

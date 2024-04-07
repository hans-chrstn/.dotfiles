{ pkgs, inputs, ... }: 
{
  # MY DE & WM
  programs.hyprland = {
    enable = true;
    #xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };

}

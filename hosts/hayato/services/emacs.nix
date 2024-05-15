{ pkgs, ... }:
{
  services.emacs = {
    enable = true;
    defaultEditor = false;
    package = with pkgs; ((emacsPackagesFor emacs-gtk).emacsWithPackages(
      epkgs: ([epkgs.vterm])
      )
    );
  };
}

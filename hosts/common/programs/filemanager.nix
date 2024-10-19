{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ 
    # FILE MANAGER | EXTRAPKGS
    lf
    yazi
    zathura 
    ctpv
  ];
}

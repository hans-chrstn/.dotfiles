{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ 
    # FILE MANAGER | EXTRAPKGS
    yazi
    zathura 
    ctpv
  ];
}

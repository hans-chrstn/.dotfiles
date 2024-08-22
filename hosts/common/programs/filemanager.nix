{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ 
    # FILE MANAGER | EXTRAPKGS
    lf
    zathura 
    ctpv
  ];
}

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ 
    # DELL
    dell-command-configure
  ];
}

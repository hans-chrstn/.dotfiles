{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # TRANSFER TO IPHONE
    libimobiledevice
    ifuse
  ];

}

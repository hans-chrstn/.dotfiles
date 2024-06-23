{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # TRANSFER TO IPHONE
    libimobiledevice
    ifuse
    # GAMING
    winetricks
    steam-run
    (lutris.override {
      extraPkgs = pkgs: [
        
      ];
    })
    (wineWowPackages.full.override {
      wineRelease = "stable";
      mingwSupport = true;
    })
    protontricks
    cartridges
    heroic
    gogdl
  ];

}

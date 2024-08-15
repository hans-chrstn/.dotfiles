{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # GAMING
    sunshine
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

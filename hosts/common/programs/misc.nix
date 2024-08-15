{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ 
    # MEDIAPLAYER
    vlc
    # BROWSER
    #floorp

  ];
}

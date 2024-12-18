{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [ 
    # MEDIAPLAYER
    vlc
    # BROWSER
    #floorp

  ];
}

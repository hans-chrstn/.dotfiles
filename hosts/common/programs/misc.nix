{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [ 
    # MEDIAPLAYER
    vlc
    # BROWSER
    #floorp
    inputs.zen-browser.packages."${system}".default

  ];
}

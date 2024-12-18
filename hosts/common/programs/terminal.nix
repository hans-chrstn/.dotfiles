{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ 
    # TERMINALS
    kitty
    wezterm
  ];
}

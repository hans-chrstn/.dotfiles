{ configs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 



  ];

  programs.zsh.enable = true;
}

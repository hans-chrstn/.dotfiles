{ configs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    curl
    jq
    coreutils
    dmidecode
    eww
    pkg-config


  ];

  programs.zsh.enable = true;
}

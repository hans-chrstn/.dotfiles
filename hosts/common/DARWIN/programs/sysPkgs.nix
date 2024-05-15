{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

    # DEVENV
    python3Full
    nodejs
    nodePackages.sass
    typescript

    # PKG UTILS
    fd
    shellcheck
    ripgrep
    openssl
    pciutils
    git
    curl
    jq
    coreutils
    nil
    socat
    file
    libglvnd
    libwebp
    meson
    eza
    bat
    code-minimap
    
    # EDITORS | EXTRA PKGS 
    neovim
    lunarvim
    xclip
    wl-clipboard

    # MEDIAPLAYER
    ffmpegthumbnailer
    ffmpeg

    # COMPRESS | ARCHIVE TOOLS
    unzip
    p7zip
    wget
    atool

    # TERMINAL 
    kitty

    # FILE MANAGER
    lf
    zathura 

    # CLI
    fzf
  ];

}

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ 
    home-manager

    # USB BOOT
    ventoy-full
    # COMPRESS & ARCHIVE TOOLS
    unzip
    p7zip
    unrar
    wget
    atool
    # SECURE BOOT KEY MANAGER
    sbctl
    # DOWNLOADS YT MP4/MP3's
    yt-dlp
    ffmpegthumbnailer
    ffmpeg-full

    fd
    shellcheck
    ripgrep
    git
    curl
    jq
    vdpauinfo
    nix-prefetch-git
    fzf
    wirelesstools
    socat
    brightnessctl
    playerctl
    file
  ];
}

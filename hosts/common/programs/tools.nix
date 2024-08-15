{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ 
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
    ffmpeg
    # SYSTEM MONITOR
    bottom
  ];
}

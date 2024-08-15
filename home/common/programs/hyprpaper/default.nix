{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      ipc = "off";
      preload = [ "~/.wallpapers/55.jpg" ];
      wallpaper = [
        "eDP-1,~/.wallpapers/55.jpg"
        "HDMI-A-1,~/.wallpapers/55.jpg"
        "HDMI-A-2,~/.wallpapers/55.jpg"
      ];

    };
  };
}

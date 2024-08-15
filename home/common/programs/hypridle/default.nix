{ ... }:
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        ignore_dbus_inhibit = false;
      };

      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
          on-resume = "notify-send '󱜚   Welcome back, $USER'";
        }
      ];

    };
  };

}

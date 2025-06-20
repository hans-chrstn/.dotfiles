{
  pkgs,
  ...
}: 
let
  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
  hyprland-session = "${pkgs.hyprland}/bin/Hyprland -c /home/mishima/.config/hypr/hyprland.conf";
in
{
  # greetd display manager
  services.greetd =  {
    enable = true;
    settings = {
      terminal.vt = 1;
      default_session = {
        command = hyprland-session; #"--sessions ${hyprland-session} --remember --remember-session"; #"${tuigreet} --time --remember --remember-session --cmd Hyprland"; 
        # user = "greeter";
        user = "mishima";
      };
    };
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };


  # unlock GPG keyring on login
  security.pam.services.greetd.enableGnomeKeyring = true;
}

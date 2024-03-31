{
  config,
  lib,
  pkgs,
  ...
}: {
  # greetd display manager
  services.greetd = let
    tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
    session = "${pkgs.hyprland}/bin/Hyprland";
    username = "hayato";
  in {
    enable = true;
    package = pkgs.greetd.tuigreet;
    settings = {
      terminal.vt = 1;
      initial_session = {
	command = "${session}";
	user = "${username}";
      };
      default_session = {
        command = "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time -cmd ${session}";
        user = "greeter";
      };
    };
  };

  # unlock GPG keyring on login
  security.pam.services.greetd.enableGnomeKeyring = true;
}

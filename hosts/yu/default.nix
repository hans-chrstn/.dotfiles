{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./sops.nix
    ./users.nix
    inputs.dotquickshell.nixosModules.default
  ];

  programs.fish.enable = true;

  fonts.packages = with pkgs; [nerd-fonts.fira-code];
  services.quickshell-greeter.enable = true;

  dotfiles = {
    hardware = {
      bluetooth.enable = true;
      intel.enable = true;
      laptop.enable = true;
      audio.enable = true;
    };
    filesystems.btrfsRollback.enable = true;
    system = {
      dbus.enable = true;
    };
    services = {
      ssh = {
        enable = true;
        passwordAuthentication = true;
      };
    };
    desktop = {
      hyprland = {
        enable = true;
        unstable = false;
      };
    };
  };
}

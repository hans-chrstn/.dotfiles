{
  config,
  modules,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./sops.nix
    inputs.dotquickshell.nixosModules.default
  ];

  programs.fish.enable = true;
  networking.hostName = "nixos-laptop";

  fonts.packages = with pkgs; [nerd-fonts.fira-code];
  services.quickshell-greeter.enable = true;

  mod = {
    hardware = {
      bluetooth.enable = true;
      intel.enable = true;
      laptop.enable = true;
      audio.enable = true;
    };
    impermanence.btrfs.enable = true;
    programs = {
      dbus.enable = true;
    };
    services = {
      ssh.enable = true;
    };
    wm = {
      niri = {
        enable = true;
        channel = "unstable";
      };
    };
  };

  users.mutableUsers = false;
  users.users = {
    "yu" = {
      isNormalUser = true;
      description = "Primary user for yu";
      extraGroups = ["wheel"];
      hashedPasswordFile = config.sops.secrets."users/jin/password".path;
      shell = pkgs.fish;
    };
    root = {
      isSystemUser = true;
      extraGroups = ["wheel"];
      hashedPasswordFile = config.sops.secrets."users/jin/password".path;
      shell = pkgs.fish;
    };
  };
}

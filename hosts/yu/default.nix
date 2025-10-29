{
  config,
  modules,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./sops.nix
    modules.intel
    modules.laptop
    modules.btrfs
    modules.audio
    modules.dbus
    modules.greetd
    modules.ssh
    modules.niri
  ];

  programs.zsh.enable = true;
  networking.hostName = "nixos-laptop";

  mod = {
    hardware = {
      intel.enable = true;
      laptop.enable = true;
      audio.enable = true;
    };
    impermanence.btrfs.enable = true;
    programs = {
      dbus.enable = true;
    };
    services = {
      greetd.enable = true;
      ssh.enable = true;
    };
    wm.niri = {
      enable = true;
      channel = "unstable";
    };
  };

  users.mutableUsers = false;
  users.users = {
    "yu" = {
      isNormalUser = true;
      description = "Primary user for yu";
      extraGroups = ["wheel"];
      hashedPasswordFile = config.sops.secrets."users/jin/password".path;
      shell = pkgs.zsh;
    };
    root = {
      isSystemUser = true;
      extraGroups = ["wheel"];
      hashedPasswordFile = config.sops.secrets."users/jin/password".path;
    };
  };
}

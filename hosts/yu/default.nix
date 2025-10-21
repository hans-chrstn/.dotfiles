{
  config,
  modules,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./sops.nix
    modules.nixos.intel
    modules.nixos.laptop
    modules.nixos.btrfs
    modules.nixos.audio
    modules.nixos.dbus
    modules.nixos.greetd
    modules.nixos.godot
    modules.nixos.ssh
    modules.nixos.niri
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
      godot.enable = true;
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

{
  pkgs,
  lib,
  config,
  modules,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./sops.nix
    modules.nixos.amd
    modules.nixos.btrfs
    modules.nixos.audio
    modules.nixos.nvidia
    modules.nixos.dbus
    modules.nixos.godot
    modules.nixos.nix-ld
    modules.nixos.steam
    modules.nixos.greetd
    modules.nixos.ssh
    modules.nixos.mangowc
    modules.nixos.niri
    modules.nixos.opengl
  ];

  mod = {
    hardware = {
      amd.enable = true;
      audio.enable = true;
      nvidia.enable = true;
      opengl.enable = true;
    };
    impermanence.btrfs.enable = true;
    programs = {
      dbus.enable = true;
      godot.enable = true;
      nix-ld.enable = true;
      steam.enable = true;
    };
    services = {
      greetd.enable = true;
      ssh.enable = true;
    };
    wm = {
      niri = {
        enable = true;
        channel = "unstable";
      };
      mangowc = {
        enable = true;
      };
    };
  };

  programs.zsh.enable = true;

  users.mutableUsers = false;
  users.users = {
    "jin" = {
      hashedPasswordFile = config.sops.secrets."users/jin/password".path;
      isNormalUser = true;
      description = "Primary user for jin";
      extraGroups = ["wheel"];
      shell = pkgs.zsh;
    };
    root = {
      hashedPasswordFile = config.sops.secrets."users/jin/password".path;
      isSystemUser = true;
      extraGroups = ["wheel"];
      shell = pkgs.zsh;
    };
  };

  systemd.network.enable = true;
  networking = {
    hostName = "nixos-main";
    networkmanager.enable = lib.mkForce false;
    useDHCP = lib.mkForce false;
    firewall = {
      allowedTCPPorts = [];
      allowedUDPPorts = [];
      allowedTCPPortRanges = [];
      allowedUDPPortRanges = [];
    };
  };
}

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
    modules.amd
    modules.btrfs
    modules.audio
    modules.nvidia
    modules.dbus
    modules.godot
    modules.nix-ld
    modules.steam
    modules.greetd
    modules.ssh
    modules.mangowc
    modules.niri
    modules.opengl
    modules.sunshine
  ];

  mod = {
    hardware = {
      amd = {
        enable = true;
        enableGpu = true;
      };
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
      sunshine.enable = true;
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

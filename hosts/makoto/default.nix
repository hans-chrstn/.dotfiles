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
    modules.audio
    modules.nvidia
    modules.dbus
    modules.nix-ld
    modules.netfs
    modules.greetd
    modules.ssh
    modules.opengl
    modules.virtualize
    modules.zfs
  ];

  services.openiscsi = {
    name = "iqn.2025-10.org.homelab-nix:nixos-server-1";
    enable = true;
    extraConfig = ''
      node.session.auth.authmethod = CHAP
      node.startup = automatic
    '';
  };

  systemd.services.iscsi-setup = {
    description = "Setup ISCSI targets";
  };

  systemd.services.zfs-import-data = {};

  systemd.services.docker = {};

  mod = {
    virtualize = {
      docker = {
        enable = true;
        enableNvidiaSupport = true;
        extraOptions = ''
          --data-root="/data/docker/root"
        '';
      };
      proxmox = {
        enable = true;
        ip = "192.168.110.3";
      };
    };
    netfs = {
      iscsi.client = {
        enable = true;
        extraConfig = ''
          node.session.auth.authmethod = CHAP
        '';
        initiatorName = "iqn.2025-10.org.homelab-nix:${config.networking.hostName}";
      };
    };
    hardware = {
      amd = {
        enable = true;
        enableGpu = true;
      };
      audio.enable = true;
      nvidia.enable = true;
      opengl.enable = true;
    };
    programs = {
      dbus.enable = true;
      nix-ld.enable = true;
    };
    services = {
      zfs = {
        enable = true;
        id = "8565dd80";
      };
      greetd.enable = true;
      ssh.enable = true;
    };
  };

  programs.zsh.enable = true;

  users.mutableUsers = false;
  users.users = {
    "makoto" = {
      hashedPasswordFile = config.sops.secrets."users/jin/password".path;
      isNormalUser = true;
      description = "Primary user for makoto";
      extraGroups = [
        "wheel"
        "docker"
        "podman"
      ];
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
    hostName = "nixos-server-1";
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

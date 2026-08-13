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
    ./services.nix
  ];

  mod = {
    virtualize = {
      docker = {
        enable = true;
        enableNvidiaSupport = true;
        extraOptions = ''
          --data-root="/data/docker/root"
        '';
      };
      # proxmox = {
      #   enable = true;
      #   ip = "192.168.110.3";
      # };
    };
    netfs = {
      iscsi.client = {
        enable = true;
        extraConfig = ''
          node.session.auth.authmethod = CHAP
          node.startup = automatic
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
      ssh = {
        enable = true;
        allowedIps = [
          "192.168.110.2/32"
          "192.168.110.3/32"
          "192.168.110.4/32"
        ];
      };
    };
  };

  programs.fish.enable = true;

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
      shell = pkgs.fish;
    };
    root = {
      hashedPasswordFile = config.sops.secrets."users/jin/password".path;
      isSystemUser = true;
      extraGroups = ["wheel"];
      shell = pkgs.fish;
    };
  };

  environment.systemPackages = with pkgs; [
    zulu25
  ];

  systemd.network.enable = true;
  networking = {
    hostName = "nixos-server-1";
    networkmanager.enable = lib.mkForce false;
    useDHCP = lib.mkForce false;
    firewall = {
      allowedTCPPorts = [];
      allowedUDPPorts = [69];
      allowedTCPPortRanges = [];
      allowedUDPPortRanges = [
        {
          from = 25550;
          to = 25560;
        }
      ];
    };
  };
}

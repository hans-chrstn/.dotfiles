{
  pkgs,
  lib,
  config,
  modules,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./sops.nix
    ./services.nix
    # inputs.wolf.nixosModules.default
  ];

  # boot.kernelModules = ["uinput" "uhid"];

  # services.udev.extraRules = ''
  #   KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess", MODE="0660", GROUP="input"
  #   KERNEL=="uhid", SUBSYSTEM=="misc", OPTIONS+="static_node=uhid", TAG+="uaccess", MODE="0660", GROUP="input"
  # '';

  # services.wolf = {
  #   enable = true;
  #   uuid = "b135b335-6200-424b-9762-5ced2c25162f";
  #   openFirewall = true;
  #   gpu.vendor = "nvidia";
  #   configDir = "/data/docker/data/GameServers/config/wolf";
  #   dataDir = "/data/docker/data/GameServers/data/wolf";
  #
  #   appExtraEnv.steam = [
  #     (
  #       "DXVK_CONFIG="
  #       + "dxgi.syncInterval = 0;"
  #       + "dxgi.maxFrameLatency = 1;"
  #       + "dxgi.maxFrameRate = 120"
  #     )
  #   ];
  #
  #   profiles = [
  #     {
  #       name = "makoto";
  #       apps = [
  #         {
  #           name = "steam";
  #           prefetch = true;
  #         }
  #       ];
  #     }
  #   ];
  # };

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
      # zfs = {
      #   enable = true;
      #   id = "8565dd80";
      # };
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
          from = 16261;
          to = 16271;
        }
      ];
    };
  };
}

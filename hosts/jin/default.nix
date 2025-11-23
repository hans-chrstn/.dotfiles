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
    modules.amd
    modules.btrfs
    modules.audio
    modules.nvidia
    modules.dbus
    modules.nix-ld
    modules.steam
    modules.greetd
    modules.ssh
    modules.mangowc
    modules.opengl
    modules.sunshine
  ];

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-substituters = [
        "https://nixos-raspberrypi.cachix.org"
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  environment.systemPackages = with pkgs; [rpi-imager];

  mod = {
    hardware = {
      amd = {
        enable = true;
      };
      audio.enable = true;
      nvidia.enable = true;
      opengl.enable = true;
    };
    impermanence.btrfs.enable = true;
    programs = {
      dbus.enable = true;
      nix-ld.enable = true;
      steam.enable = true;
    };
    services = {
      sunshine.enable = false;
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
    wm = {
      # niri = {
      #   enable = true;
      #   channel = "unstable";
      # };
      mangowc = {
        enable = true;
      };
    };
  };

  programs.fish.enable = true;

  users.mutableUsers = false;
  users.users = {
    "jin" = {
      hashedPasswordFile = config.sops.secrets."users/jin/password".path;
      isNormalUser = true;
      description = "Primary user for jin";
      extraGroups = ["wheel"];
      shell = pkgs.fish;
    };
    root = {
      hashedPasswordFile = config.sops.secrets."users/jin/password".path;
      isSystemUser = true;
      extraGroups = ["wheel"];
      shell = pkgs.fish;
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

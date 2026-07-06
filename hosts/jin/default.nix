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
    inputs.dotquickshell.nixosModules.default
  ];

  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "logi-bolt-uaccess";
      text = ''
        # Match any hidraw device whose parent is our Logitech device
        SUBSYSTEM=="hidraw", SUBSYSTEMS=="hid", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c548", TAG+="uaccess"
      '';
      destination = "/etc/udev/rules.d/50-logi-bolt.rules";
    })
  ];
  services.mysql = {
    enable = true;
    package = pkgs.mysql84;
  };

  fonts.packages = with pkgs; [nerd-fonts.fira-code];

  environment.systemPackages = with pkgs; [
    davinci-resolve
    zrythm
    zulu25
    usbutils
  ];

  boot.ntsync.enable = true;

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      trusted-substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  mod = {
    hardware = {
      amd = {
        enable = true;
        enableGpu = true;
      };
      audio.enable = true;
      bluetooth.enable = true;
      opengl.enable = true;
    };
    impermanence.btrfs.enable = true;
    programs = {
      dbus.enable = true;
      nix-ld.enable = true;
      steam.enable = true;
    };
    services = {
      sunshine.enable = true;
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
      hyprland.enable = true;
      niri = {
        enable = true;
        channel = "unstable";
      };
    };
  };

  services.quickshell-greeter.enable = true;

  programs.fish.enable = true;

  users.mutableUsers = false;
  users.users = {
    "jin" = {
      hashedPasswordFile = config.sops.secrets."users/jin/password".path;
      isNormalUser = true;
      description = "Primary user for jin";
      extraGroups = ["wheel" "audio" "jackaudio" "adbusers"];
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

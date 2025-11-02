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
    modules.greetd
    modules.ssh
    modules.opengl
    modules.netfs
    modules.clamav
    modules.virtualize
    modules.zfs
  ];

  services.target = {
    enable = true;
  };

  mod = {
    hardware = {
      amd = {
        enable = true;
        enableGpu = true;
      };
      audio.enable = true;
      opengl.enable = true;
    };
    netfs = {
      enableNfs = true;
      smb = {
        enable = true;
      };
      iscsi.server = {
        enable = true;
      };
    };
    programs = {
      dbus.enable = true;
      nix-ld.enable = true;
    };
    services = {
      zfs = {
        enable = true;
        id = "fffafb21";
        importPools = ["tank"];
      };
      clamav = {
        enable = true;
        directories = [
          "/tank"
        ];
      };
      greetd.enable = true;
      ssh.enable = true;
    };
  };

  programs.zsh.enable = true;

  users.mutableUsers = false;
  users.users = {
    "rei" = {
      hashedPasswordFile = config.sops.secrets."users/jin/password".path;
      isNormalUser = true;
      description = "Primary user for rei";
      extraGroups = ["wheel"];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keyFiles = [
        config.sops.secrets."users/jin/ssh/public".path
      ];
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
    hostName = "nixos-server-2";
    networkmanager.enable = lib.mkForce false;
    useDHCP = lib.mkForce false;
    firewall = {
      allowedTCPPorts = [3260];
      allowedUDPPorts = [];
      allowedTCPPortRanges = [];
      allowedUDPPortRanges = [];
    };
  };
}

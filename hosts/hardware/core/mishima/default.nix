{ inputs, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.sops-nix.nixosModules.sops
  ];

  nix = {
    settings = {
      cores = 12;
      max-jobs = 24;
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  boot = {
    supportedFilesystems = ["ntfs"];

    kernelModules = [
    ];

    kernel.sysctl = {
      "vm.swappiness" = 60;  #default = 60
      "vm.nr_hugepages" = 0;

    };
    kernelParams = [
      "quiet"
      "splash"
      # "nomodeset"
      "nvidia-drm.modeset=1"
      "amdgpu.sg_display=0"
      "nvidia-drm.fbdev=1"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
      "amd_iommu=on"
    ];

    #kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      systemd-boot.consoleMode = "max";
      systemd-boot.editor = false;
      timeout = 4;
      efi.efiSysMountPoint = "/boot";
    };
    tmp.cleanOnBoot = true;
  };

  environment.systemPackages = with pkgs; [
    age
    gnupg
    sops
    ssh-to-age
  ];

  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    secrets = {
      "users/mishima/password" = {};
      "networks/mishima/main/name" = {};
      "networks/mishima/main/dhcp" = {};
      "networks/mishima/vm/kind" = {};
      "networks/mishima/vm/name" = {};
      "networks/mishima/bridge/name" = {};
      "networks/mishima/bridge/dhcp" = {};
      "networks/mishima/bridge/mad" = {};
    };
    templates = {
      "10-lan.network" = {
        content = ''
          [Match]
          Name=${config.sops.placeholder."networks/mishima/main/name"}

          [Network]
          Bridge=${config.sops.placeholder."networks/mishima/vm/name"}
          DHCP=${config.sops.placeholder."networks/mishima/main/dhcp"}
        '';
        mode = "0644";
        path = "/etc/systemd/network/10-lan.network";
      };

      "10-lan-bridge.network" = {
        content = ''
          [Match]
          Name=${config.sops.placeholder."networks/mishima/bridge/name"}

          [Link]
          RequiredForOnline=routable
          MACAddress=${config.sops.placeholder."networks/mishima/bridge/mad"}

          [Network]
          DHCP=${config.sops.placeholder."networks/mishima/bridge/dhcp"}
        '';
        mode = "0644";
        path = "/etc/systemd/network/10-lan-bridge.network";
      };

      "vmbr0.netdev" = {
        content = ''
          [NetDev]
          Kind=${config.sops.placeholder."networks/mishima/vm/kind"}
          Name=${config.sops.placeholder."networks/mishima/vm/name"}
        '';
        mode = "0644";
        path = "/etc/systemd/network/vmbr0.netdev";
      };
    };
  };
}

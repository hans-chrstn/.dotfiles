{ inputs, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    inputs.sops-nix.nixosModules.sops
  ];

  nix = {
    settings = {
      cores = 4;
      max-jobs = 8;
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
    blacklistedKernelModules = [ "ucsi_ccg" "typec_ucsi" "i2c_ccgx_ucsi" ];

    kernel.sysctl = {
      "vm.swappiness" = 60;  #default = 60
      "vm.nr_hugepages" = 0;

    };
    kernelParams = [
      "quiet"
      "splash"
      "nomodeset" # remove if using igpu
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];

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
    defaultSopsFile = ../../../../secrets/secrets.yaml;
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    secrets = {
      "users/mishima/password" = {};
      "networks/masato/main/name" = {};
      "networks/masato/main/dhcp" = {};
      "networks/masato/vm/kind" = {};
      "networks/masato/vm/name" = {};
      "networks/masato/bridge/name" = {};
      "networks/masato/bridge/dhcp" = {};
      "networks/masato/bridge/mad" = {};
    };
    templates = {
      "10-lan.network" = {
        content = ''
          [Match]
          Name=${config.sops.placeholder."networks/masato/main/name"}

          [Network]
          Bridge=${config.sops.placeholder."networks/masato/vm/name"}
          DHCP=${config.sops.placeholder."networks/masato/main/dhcp"}
        '';
        mode = "0644";
        path = "/etc/systemd/network/10-lan.network";
      };

      "10-lan-bridge.network" = {
        content = ''
          [Match]
          Name=${config.sops.placeholder."networks/masato/bridge/name"}

          [Link]
          RequiredForOnline=routable
          MACAddress=${config.sops.placeholder."networks/masato/bridge/mad"}

          [Network]
          DHCP=${config.sops.placeholder."networks/masato/bridge/dhcp"}
        '';
        mode = "0644";
        path = "/etc/systemd/network/10-lan-bridge.network";
      };

      "vmbr0.netdev" = {
        content = ''
          [NetDev]
          Kind=${config.sops.placeholder."networks/masato/vm/kind"}
          Name=${config.sops.placeholder."networks/masato/vm/name"}
        '';
        mode = "0644";
        path = "/etc/systemd/network/vmbr0.netdev";
      };
    };
  };
}

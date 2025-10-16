{ inputs, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.sops-nix.nixosModules.sops
  ];

  nix = {
    settings = {
      cores = 4;
      max-jobs = 4;
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
        "acpi_call"
    ];

    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

    kernel.sysctl = {
      "vm.swappiness" = 60;  #default = 60
      "vm.nr_hugepages" = 0;

    };
    initrd = {
      kernelModules = [
        "i915"
      ];
      compressor = "xz";
    };

    kernelParams = [
      "i915.force_probe=8a56"
      "i915.enable_guc=2"
      "i915.enable_fbc=1"
      "i915.enable_psr=2"
      "1915.enable_gvt=0"
      "i915.fastboot=1"
      "i915.mitigations=off"
      "i915.modeset=1"
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];

    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      systemd-boot.consoleMode = "auto";
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
      "networks/wg-laptop/interface/private-key" = {};
      "networks/wg-laptop/interface/address" = {};
      "networks/wg-laptop/interface/dns" = {};
      "networks/wg-laptop/peer/public-key" = {};
      "networks/wg-laptop/peer/preshared-key" = {};
      "networks/wg-laptop/peer/allowed-ips" = {};
      "networks/wg-laptop/peer/endpoint" = {};
    };
    templates = {
      "unsecured" = {
        content = ''
          [Interface]
          PrivateKey = ${config.sops.placeholder."networks/wg-laptop/interface/private-key"}
          Address = ${config.sops.placeholder."networks/wg-laptop/interface/address"}
          DNS = ${config.sops.placeholder."networks/wg-laptop/interface/dns"}

          [Peer]
          PublicKey = ${config.sops.placeholder."networks/wg-laptop/peer/public-key"}
          PresharedKey = ${config.sops.placeholder."networks/wg-laptop/peer/preshared-key"}
          AllowedIPs = ${config.sops.placeholder."networks/wg-laptop/peer/allowed-ips"}
          Endpoint = ${config.sops.placeholder."networks/wg-laptop/peer/endpoint"}
          PersistentKeepalive = 25
        '';
        path = "/etc/wireguard/unsecured.conf";
      };
    };
  };
}

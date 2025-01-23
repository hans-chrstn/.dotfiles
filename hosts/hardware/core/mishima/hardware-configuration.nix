# This is just an example, you should generate yours with nixos-generate-config and put it in here.
{ config, lib, pkgs, modulesPath, ... }:
{

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
	"ahci"
	"nvme"
	"usbhid"
	"usb_storage"
	"sd_mod"
      ];
      kernelModules = [];
      luks.devices."enc" = {
        device = "/dev/nvme0n1p1";
	preLVM = true;
      };
    };
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };
  fileSystems."/" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" "noatime" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" "noatime" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=log" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

  fileSystems."/etc/secureboot" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=secureboot" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

  fileSystems."/etc/pve" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=proxmox" "compress=zstd" "noatime" ];
    };

  fileSystems."/var/lib/pve-firewall" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=proxmox" "compress=zstd" "noatime" ];
    };

  fileSystems."/var/lib/pve-cluster" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=proxmox" "compress=zstd" "noatime" ];
    };

  fileSystems."/var/lib/pve-manager" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=proxmox" "compress=zstd" "noatime" ];
    };

  fileSystems."/var/lib/vz" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=proxmox" "compress=zstd" "noatime" ];
    };
  fileSystems."/var/lock" =
    { device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [ "subvol=proxmox" "compress=zstd" "noatime" ];
    };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = [
      "umask=0077"
    ];
  };

  # Set your system kind (needed for flakes)
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  networking.useDHCP = lib.mkDefault true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

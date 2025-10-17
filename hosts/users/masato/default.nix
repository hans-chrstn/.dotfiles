{ config, pkgs, outputs, inputs, lib, ... }:
{
  imports = [
    ../../common/masato.nix
    ./overlays.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  environment.systemPackages = [
    pkgs.hyprsysteminfo
  ];

  services.proxmox-ve = {
    vms = {
      "MacOS" = {
        # Based on klabsdev article
        # AMD now add this to /etc/pve/qemu-server/yourvmid.conf args: -device isa-applesmc,osk="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc" -smbios type=2 -device qemu-xhci -device usb-tablet -device usb-kbd,bus=ehci.0,port=2 -global nec-usb-xhci.msi=off -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off -cpu Haswell-noTSX,vendor=GenuineIntel,+invtsc,+hypervisor,kvm=on,vmware-cpuid-freq=on
        # /var/lib/vz/template/iso/...
        vmid = 100;
        memory = 4096;
        cores = 4;
        sockets = 1;
        net = [
          { model = "virtio"; bridge = "vmbr0"; }
        ];
        virtio = [
          { file = "Z1:64"; iothread = true; cache = "unsafe"; discard = "on"; format = "qcow2"; }
        ];
        ide = [
          { file = "local:iso/OpenCore-v21.iso"; cache = "unsafe"; size = "150M"; }
          { file = "local:iso/macOS-Sequoia-15.4.iso"; cache = "unsafe"; size = "17000M"; }
        ];
        ostype = "other";
        machine = { type = "q35"; viommu = "virtio"; };
        bios = "ovmf";
        scsihw = "virtio-scsi-pci";
        efidisk0 = {
          file = "local:1";
          efitype = "4m";
          format = "qcow2";
          # doesn't work
          pre-enrolled-keys = false;
        };

        vga = {
          type = "vmware";
          memory = 512;
        };
      };

      "BlissOS" = {
        vmid = 101;
        memory = 8096;
        cores = 4;
        sockets = 1;
        net = [
          { model = "virtio"; bridge = "vmbr0"; }
        ];
        sata = [
          { file = "local:64"; format = "qcow2"; }
        ];
        ide = [
          { file = "local:iso/Bliss-v16.9.7-x86_64-OFFICIAL-gapps-20241011.iso"; size = "3072M"; }
        ];
        ostype = "l26";
        machine = { type = "q35"; viommu = "intel"; };
        bios = "ovmf";
        scsihw = "virtio-scsi-single";
        efidisk0 = {
          file = "local:1";
          efitype = "4m";
          format = "qcow2";
          pre-enrolled-keys = false;
        };
      };
    };
  };

  mod = {
    ssh.enable = true;
    virtualize = {
      proxmox = {
        enable = true;
        ip = "192.168.110.3";
      };
    };
  };
}

{ inputs, lib, pkgs, config, ... }:
with lib;
let
 cfg = config.programs.virtualise; 
in 
{
  options.programs.virtualise = {
    enable = mkEnableOption "Enable virtualization modules and packages";
    proxmoxIP = mkOption {
      type = types.str;
      default = "192.168.1.10";
      description = "IP address of the Proxmox node in string.";
    };
  };

  imports = [
    inputs.proxmox-nixos.nixosModules.proxmox-ve
  ];

  config = mkIf cfg.enable {
    virtualisation = {
      waydroid.enable = true;
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;


    services.proxmox-ve = {
      enable = true;
      ipAddress = "cfg.proxmoxIP";
    };
  };
}

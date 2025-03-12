{ inputs, lib, pkgs, config, ... }:
with lib;
let
 cfg = config.programs.virtualise; 
in 
{
  options.programs.virtualise = {
    enable = mkEnableOption "Enable virtualization modules and packages";
  };

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

  };
}

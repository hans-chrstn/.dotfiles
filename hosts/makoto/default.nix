{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./sops.nix
    ./services.nix
    ./users.nix
  ];

  boot.kernelModules = [
    "kvm"
    "kvm_amd"
  ];

  dotfiles = {
    virtualization = {
      docker = {
        enable = true;
        enableNvidiaSupport = true;
        dataRoot = "/data/docker/root";
      };
    };
    filesystems.network = {
      iscsi.client = {
        enable = true;
        extraConfig = ''
          node.session.auth.authmethod = CHAP
          node.startup = automatic
        '';
        initiatorName = "iqn.2025-10.org.homelab-nix:${config.networking.hostName}";
      };
    };
    hardware = {
      amd = {
        enable = true;
        enableGpu = true;
      };
      audio.enable = true;
      nvidia.enable = true;
      opengl.enable = true;
    };
    system = {
      dbus.enable = true;
      nix-ld.enable = true;
    };
    desktop.greetd.enable = true;
    services = {
      ssh = {
        enable = true;
        passwordAuthentication = true;
        allowedIps = [
          "192.168.110.2/32"
          "192.168.110.3/32"
          "192.168.110.4/32"
        ];
      };
    };
  };

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    zulu25
  ];
}

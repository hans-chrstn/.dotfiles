{...}: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./sops.nix
    ./services.nix
    ./users.nix
  ];

  services.target = {
    enable = true;
  };

  dotfiles = {
    hardware = {
      amd = {
        enable = true;
        enableGpu = true;
      };
      audio.enable = true;
      opengl.enable = true;
    };
    filesystems.network = {
      nfs.enable = true;
      smb = {
        enable = true;
        openFirewall = true;
      };
      iscsi.server = {
        enable = true;
        allowedIps = ["192.168.110.3/32"];
      };
    };
    system = {
      dbus.enable = true;
      nix-ld.enable = true;
    };
    filesystems.zfs = {
      enable = true;
      id = "fffafb21";
      importPools = ["tank"];
    };
    desktop.greetd.enable = true;
    services = {
      clamav = {
        enable = true;
        directories = [
          "/tank"
        ];
      };
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

  programs.zsh.enable = true;
}

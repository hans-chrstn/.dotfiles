{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./sops.nix
    ./services.nix
    ./storage.nix
    ./users.nix
    inputs.dotquickshell.nixosModules.default
    inputs.crab.nixosModules.default
  ];

  services.crab.enable = true;

  services.mysql = {
    enable = true;
    package = pkgs.mysql84;
  };

  fonts.packages = with pkgs; [nerd-fonts.fira-code];

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  dotfiles = {
    hardware = {
      amd = {
        enable = true;
        enableGpu = true;
      };
      audio.enable = true;
      bluetooth.enable = true;
      opengl.enable = true;
    };
    filesystems.btrfsRollback.enable = true;
    system = {
      dbus.enable = true;
      nix-ld.enable = true;
    };
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
    desktop = {
      hyprland = {
        enable = true;
        unstable = false;
      };
    };
  };

  services.quickshell-greeter.enable = true;

  programs.fish.enable = true;
}

{ pkgs, inputs, ... }:

{
  imports = [
    ./programs.nix
    ./overlays.nix
    ../../common/toru.nix
  ];

  home = {
    username = "toru";
    homeDirectory = "/home/toru";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
  home.stateVersion = "24.11";
}

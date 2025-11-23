{
  pkgs,
  modules,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # nixpkgs.overlays = [
  # Add overlays your own flake exports (from overlays and pkgs dir):
  # outputs.overlays.additions
  # outputs.overlays.modifications
  #
  # You can also add overlays exported from other flakes:
  # neovim-nightly-overlay.overlays.default
  #
  # Or define it inline, for example:
  # (final: prev: {
  #   hi = final.hello.overrideAttrs (oldAttrs: {
  #     patches = [ ./change-hello-to-hi.patch ];
  #   });
  # })
  # ];

  hardware.graphics.enable32Bit = lib.mkForce false;

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
  };

  programs.zsh.enable = true;

  users.users = {
    "chu" = {
      isNormalUser = true;
      description = "Primary user for chu";
      extraGroups = ["wheel"];
      password = "123";
      shell = pkgs.zsh;
    };
    root = {
      isSystemUser = true;
      extraGroups = ["wheel"];
      password = "123";
    };
  };
}

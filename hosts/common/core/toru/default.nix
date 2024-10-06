{ inputs, outputs, lib, config, pkgs, ... }:
{
  imports = [
    # include NixOS-WSL modules
    inputs.nixos-wsl.nixosModules.default
  ];

  wsl = {
    enable = true;
    defaultUser = "toru";
  };

  environment.systemPackages = with pkgs; [
    git
    neovim
    home-manager
  ];
}

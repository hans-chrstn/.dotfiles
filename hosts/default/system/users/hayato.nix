{ config, pkgs, ... }:

{
  users.users = {
    hayato = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "admin"];
      shell = pkgs.zsh;
    };
  };
}

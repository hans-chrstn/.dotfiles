{ config, pkgs, ... }:

{
  users.users = {
    guest = {
      isNormalUser = true;
      extraGroups = ["guest"];
    };
  };
}

{ pkgs, config, ... }:
let
  hostGroups = [
    "wheel"
    "wireshark"
    "admin"
    "adbusers"
    "input"
    "libvirtd"
    "plugdev"
    "transmission"
    "video"
  ];
in
{
  sops.secrets = {
    "users/mishima/password".neededForUsers = true;
  };

  users.users = {
    masato = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets."users/mishima/password".path;
      extraGroups = hostGroups;
      shell = pkgs.zsh;
    };
    toru = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets."users/mishima/password".path;
      shell = pkgs.zsh;
    };
    mishima = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets."users/mishima/password".path;
      extraGroups = hostGroups;
      shell = pkgs.zsh;
    };
    hayato = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets."users/mishima/password".path;
      extraGroups = [
        "networkmanager"
      ];
      shell = pkgs.zsh;
    };

    root = {
      isSystemUser = true;
      hashedPasswordFile = config.sops.secrets."users/mishima/password".path;
      extraGroups = hostGroups ++ [ "root" ];
      shell = pkgs.zsh;
    };
  };
}

{config, ...}: {
  dotfiles.gaming.steam.enable = true;
  home-manager.users.${config.dotfiles.primaryUser}.dotfiles.gaming.packages.enable = true;
  boot.ntsync.enable = true;
}

{
  config,
  pkgs,
  ...
}: {
  users.mutableUsers = false;
  users.users = {
    rei = {
      hashedPasswordFile = config.sops.secrets."users/jin/password".path;
      isNormalUser = true;
      description = "Primary user for rei";
      extraGroups = ["wheel"];
      shell = pkgs.zsh;
    };
    root = {
      hashedPassword = "!";
      shell = pkgs.zsh;
    };
  };
}

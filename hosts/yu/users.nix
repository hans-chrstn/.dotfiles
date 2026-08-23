{
  config,
  pkgs,
  ...
}: {
  users.mutableUsers = false;
  users.users = {
    yu = {
      hashedPasswordFile = config.sops.secrets."users/jin/password".path;
      isNormalUser = true;
      description = "Primary user for yu";
      extraGroups = ["wheel"];
      shell = pkgs.fish;
    };
    root = {
      hashedPassword = "!";
      shell = pkgs.fish;
    };
  };
}

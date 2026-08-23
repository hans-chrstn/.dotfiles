{
  config,
  pkgs,
  ...
}: {
  users.mutableUsers = false;
  users.users = {
    jin = {
      hashedPasswordFile = config.sops.secrets."users/jin/password".path;
      isNormalUser = true;
      description = "Primary user for jin";
      extraGroups = ["wheel" "audio" "jackaudio" "adbusers" "input"];
      shell = pkgs.fish;
    };
    root = {
      hashedPassword = "!";
      shell = pkgs.fish;
    };
  };
}

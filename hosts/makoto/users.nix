{
  config,
  pkgs,
  ...
}: {
  users.mutableUsers = false;
  users.users = {
    makoto = {
      hashedPasswordFile = config.sops.secrets."users/jin/password".path;
      isNormalUser = true;
      description = "Primary user for makoto";
      extraGroups = ["wheel" "docker" "podman" "kvm"];
      shell = pkgs.fish;
    };
    root = {
      hashedPassword = "!";
      shell = pkgs.fish;
    };
  };
}

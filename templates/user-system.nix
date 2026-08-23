{pkgs, ...}: {
  users.users.NEW_USERNAME = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    hashedPassword = "!";
    shell = pkgs.bashInteractive;
  };
}

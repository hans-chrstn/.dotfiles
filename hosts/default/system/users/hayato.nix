{ config, pkgs, ... }:

{
  environment.sessionVariables = {
    EDITOR = "lvim";
    VISUAL = "lvim";
  };
  users.users = {
    hayato = {
      isNormalUser = true;
      extraGroups = [
        "wheel" 
	      "networkmanager" 
	      "admin"
	      "adbusers"
	      "input"
	      "libvirtd"
	      "plugdev"
	      "transmission"
	      "video"
      ];

      shell = pkgs.zsh;
    };
  };
  services.openssh = {
    enable = false; #true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = false;
    };
  };
}

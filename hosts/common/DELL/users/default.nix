{ pkgs, ... }:

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
        "wireshark"
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

    pentest = {
      isNormalUser = true;
      extraGroups = [
        "wheel" 
	      "networkmanager" 
        "wireshark"
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
}

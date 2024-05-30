{ pkgs, ... }:

{
  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
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

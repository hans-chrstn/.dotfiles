{ config, pkgs, ... }:

{
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
}

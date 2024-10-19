{ pkgs, ... }:

{
  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  users.users = {
    toru = {
      isNormalUser = true;
      hashedPassword = "$6$MOUYs8IWK9URS8OP$HLcnWgm2MM7YWRsJtQ0Xl3OGB5BuFkiJeHYIBABADm9XFDuB0izvBa5nrzki8MbBk49FKbvTQ23c22WNO/XrJ/";
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
    mishima = {
      isNormalUser = true;
      hashedPassword = "$6$MOUYs8IWK9URS8OP$HLcnWgm2MM7YWRsJtQ0Xl3OGB5BuFkiJeHYIBABADm9XFDuB0izvBa5nrzki8MbBk49FKbvTQ23c22WNO/XrJ/";
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
        "docker"
      ];

      shell = pkgs.zsh;
    };
    hayato = {
      isNormalUser = true;
      hashedPassword = "$6$MOUYs8IWK9URS8OP$HLcnWgm2MM7YWRsJtQ0Xl3OGB5BuFkiJeHYIBABADm9XFDuB0izvBa5nrzki8MbBk49FKbvTQ23c22WNO/XrJ/";
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

    root = {
      isSystemUser = true;
      hashedPassword = "$6$MOUYs8IWK9URS8OP$HLcnWgm2MM7YWRsJtQ0Xl3OGB5BuFkiJeHYIBABADm9XFDuB0izvBa5nrzki8MbBk49FKbvTQ23c22WNO/XrJ/";
      extraGroups = [
        "root"
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

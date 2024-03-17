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
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+bs4IkfF/mKColG1jYMl+CooLs1jKBm2aVQY8tDAy8QMGMScBOJL+Agnh7UD24sr/hbmu8rfdbzGb+cbEPQFQsB9FlNxvawXPzaCHqgf9zLLY/psEybOhR10C3MHkB4YqNlN9mqKRrH9yw68CGKL3fKNc47jLgJh/iST9yBjorH0GkEJMxDYIdcOfO/Uzaerhtc3Lve/TZlWwPefXnzJgf1zUwtmBx893yD6xKBLIPeckfWguBdt9ZES+MtjySBtp2IqCljcn4yuy3my1Sjq3t7O8VKHeuDv2yAkqINqpgZrZZ1uc/E9wFabkhEqyCSrTNBGcKeQgNPtMgX7J0ukSB16xNUa5gQib4on126xWLX4qNR/sIgKKxm0emSMaW7a0ZY9mlJHE7zfJ5HU2+QG176lA1DQX37Wqd6SCy3Abl/JpC8ncjquT7On1J3GOItjqPOiZIWnGRgS6aogcGnY4LA39eqQNh3oy66CYI2FUYAy9co1z1afNNKIDYkbR8PeUxNVlcGWJT7P9UuxI7e5ewAUG2HA67smEo2y8OyOCFGc3E4nVjFGFFTJ2L4Wv8EOspVevAka3gEk/zu/12wYS143ra+G11GX7myIW9mkZo4pzXBFBtcKJOd1iWpPpmJqFIhaAhN0E7oiXvr6OmV5YrNj1JpMsXG4jB4OM56iXIw== xuhiko13@gmail.com"
      ];
    };
  };
  services.openssh = {
    enable = true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = false;
    };
  };
}

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
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDTxdij2o5thE0CnS1COZcUskaL2rRbmyZg5/WP7oU0y9puHNRW7WU6sL0XSslyuY9WIwY55R2pgb4g/C2kpKUvse7MKP2nfraKPfJQ4dBe8NrZl/F/r8rrwTW5zq0Hx9iOMKi91MtKw54II1PPOnH6BOD8pr8+LtsU128aLuM4jqi+X7wtBTq2wvq50moJHFiGq7JPT/AuZEsvZThhZ1hDz3+TeVRjC58tqHcYTJhw+gbzpmgZjiN53Cj52GJayIbfzZ4ut9PxE7p+z4hhLivTJIh5wCUFkC1Dcyzfhw8jk5TprRWKwUj8U24ZfQBWRI5w1g9NKulDYB2IM8tx3TqYrsXbRwLwYwtRNm/lcsYWgc7L+uo/T5X3yo3Cli3pFcsRBXc/gCdQJBs73FvvTlrfDu8SOOq8YZsDeXJYPzaZAi5ye4g9sdby6x5TNwxrz2mE8k5rKlXeP6B1eShqZQE4otz5P4OOVH741u2l6MTFLGQLs7ajD3ugyV3E4rlaANr+X8Z4yj+sKXURU4XnFxz2rt9sInsO5peDp/iQSYLv9EaR2bCxq7wlf6gyObpP4Yw6xrWneC3pfPFotCSDylc1amMtsHtFt2kaDNGUL6pgZvOWEXzQ+uRIZ1XWgkhFGGUrA2xFEwYqPX2gJkoiD3tJpaY0qo1XPDRUe/G7xQOsTQ== xuhiko13@gmail.com"
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

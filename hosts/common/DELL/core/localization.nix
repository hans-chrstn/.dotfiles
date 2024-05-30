{ pkgs, ... }:

{

  services.xserver = {
    xkb.layout = "us, kr";
    xkb.variant = "";
    xkb.options = "grp:win_space_toggle";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    #inputMethod = {
    #  enabled = "ibus";
    #  ibus = {
    #    engines = with pkgs.ibus-engines; [
    #      hangul
    #    ];
    #  };
    #};
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

}

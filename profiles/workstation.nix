{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    davinci-resolve
    usbutils
    zrythm
    zulu25
  ];
}

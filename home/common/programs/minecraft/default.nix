{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (prismlauncher.override {
      additionalPrograms = [ ffmpeg ];
      jdks = [
        graalvm-ce
        zulu8
        zulu17
        zulu
      ];
    })
  ];
}

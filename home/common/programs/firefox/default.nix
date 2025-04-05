{ pkgs, inputs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta;
  };
}

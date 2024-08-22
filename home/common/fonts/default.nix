{ pkgs, ... }:
let
  apple-fonts = pkgs.callPackage ./build/apple-fonts.nix { };
  bebasneue = pkgs.callPackage ./build/bebasneue.nix { };
in

{
  fonts.fontconfig.enable = true;
  home.packages = [
    bebasneue
    apple-fonts
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];
}

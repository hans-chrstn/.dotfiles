{pkgs}: {
  render-markdown = pkgs.callPackage ./render-markdown {};
  magazine = pkgs.callPackage ./magazine {};
  drop = pkgs.callPackage ./drop {};
}

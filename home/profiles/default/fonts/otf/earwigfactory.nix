{ lib, stdenv, fetchurl, p7zip }:

stdenv.mkDerivation rec {
  pname = "Earwig-Factory";
  version = "1";

  earwigFactory = fetchurl {
    url = "https://github.com/hans-chrstn/fonts/releases/download/Public/earwig.factory.rg.zip";
    sha256 = "sha256-C8+c0apYYwt+tmrhTsSGgmHcjMZuKo8DlH+8/E6pL/I=";
  };

  nativeBuildInputs = [ p7zip ];

  dontUnpack = "true";

  installPhase = ''
    mkdir -p $out/share/fonts/opentype/${pname}/
    7z x ${earwigFactory} -o$out/share/fonts/opentype/${pname}/ 
  '';

  meta = {
    description = "${pname}";
    homepage = "https://github.com/hans-chrstn/fonts/releases/tag/Public";
    license = lib.licenses.unfree;
  };
}

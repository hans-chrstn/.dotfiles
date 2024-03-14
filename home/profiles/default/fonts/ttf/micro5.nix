{ lib, stdenv, fetchurl, p7zip }:

stdenv.mkDerivation rec {
  pname = "Micro5-Regular";
  version = "1";

  micro5 = fetchurl {
    url = "https://github.com/hans-chrstn/fonts/releases/download/Public/Micro5-Regular.zip";
    sha256 = "sha256-dais+cF4w7F+pN2Rkt8o2i9JKgbuKrQNWdOYmDEL5sw=";
  };

  nativeBuildInputs = [ p7zip ];

  dontUnpack = "true";

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/${pname}/
    7z x ${micro5} -o$out/share/fonts/truetype/${pname}/ 
  '';

  meta = {
    description = "${pname}";
    homepage = "https://github.com/hans-chrstn/fonts/releases/tag/Public";
    license = lib.licenses.unfree;
  };
}

{ lib, stdenv, fetchurl, p7zip }:

stdenv.mkDerivation rec {
  pname = "Poiretone-Regular";
  version = "1";

  poiretone-r = fetchurl {
    url = "https://github.com/hans-chrstn/fonts/releases/download/Public/PoiretOne-Regular.zip";
    sha256 = "sha256-9er95WdP4izlmm5+3Kb8CYNr3Y2KRhOkpi3U4Y/RZZw=";
  };

  nativeBuildInputs = [ p7zip ];

  dontUnpack = "true";

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/${pname}/
    7z x ${poiretone-r} -o$out/share/fonts/truetype/${pname}/ 
  '';

  meta = {
    description = "PoiretOne-Regular";
    homepage = "https://github.com/hans-chrstn/fonts/releases/tag/Public";
    license = lib.licenses.unfree;
  };
}

{ lib, stdenv, fetchurl, p7zip }:

stdenv.mkDerivation rec {
  pname = "Phosphor";
  version = "1";

  phosphor = fetchurl {
    url = "https://github.com/hans-chrstn/fonts/releases/download/Public/Phosphor.zip";
    sha256 = "sha256-xozKiVpAQvIp2lvy+yFMjAIzC2vLX7weDsz8eUn7wHU=";
  };

  nativeBuildInputs = [ p7zip ];

  dontUnpack = "true";

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/${pname}/
    7z x ${phosphor} -o$out/share/fonts/truetype/${pname}/ 
  '';

  meta = {
    description = "Phosphor";
    homepage = "https://github.com/hans-chrstn/fonts/releases/tag/Public";
    license = lib.licenses.unfree;
  };
}

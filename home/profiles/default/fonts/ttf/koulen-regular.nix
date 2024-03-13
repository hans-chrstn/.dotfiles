{ lib, stdenv, fetchurl, p7zip }:

stdenv.mkDerivation rec {
  pname = "Koulen-Regular";
  version = "1";

  koulen-r = fetchurl {
    url = "https://github.com/hans-chrstn/fonts/releases/download/Public/Koulen-Regular.zip";
    sha256 = "sha256-7oFwaCTngDTF8N2TzbE/alM5n2jXFy5t3pkfcnzQRGI=";
  };

  nativeBuildInputs = [ p7zip ];

  dontUnpack = "true";

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/${pname}/
    7z x ${koulen-r} -o$out/share/fonts/truetype/${pname}/ 
  '';

  meta = {
    description = "test";
    homepage = "https://github.com/hans-chrstn/fonts/releases/tag/Public";
    license = lib.licenses.unfree;
  };
}

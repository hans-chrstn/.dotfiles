{ lib, stdenv, fetchurl, p7zip }:

stdenv.mkDerivation rec {
  pname = "Forced-Square";
  version = "1";

  forcedSquare = fetchurl {
    url = "https://github.com/hans-chrstn/fonts/releases/download/Public/forced_square.zip";
    sha256 = "sha256-DQFrU3Ag/slZMv4Zmarf5U1yH51SRMXaHf+l/TGS4W4=";
  };

  nativeBuildInputs = [ p7zip ];

  dontUnpack = "true";

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/${pname}/
    7z x ${forcedSquare} -o$out/share/fonts/truetype/${pname}/ 
  '';

  meta = {
    description = "${pname}";
    homepage = "https://github.com/hans-chrstn/fonts/releases/tag/Public";
    license = lib.licenses.unfree;
  };
}

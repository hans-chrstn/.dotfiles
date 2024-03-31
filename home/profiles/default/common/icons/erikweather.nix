{ lib, stdenv, fetchurl, p7zip }:

stdenv.mkDerivation rec {
  pname = "WeatherIconsErik";
  version = "1";

  weathericonserik = fetchurl {
    url = "https://github.com/hans-chrstn/.fonts/releases/download/Public/WeatherIconsErik.zip";
    sha256 = "sha256-9CW/u7QXNdDCbZAVKNCi2kt9sSgA1DBX+Sk1QxUK1Cs=";
  };

  nativeBuildInputs = [ p7zip ];

  dontUnpack = "true";

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/${pname}/
    7z x ${weathericonserik} -o$out/share/fonts/truetype/${pname}/ 
  '';

  meta = {
    description = "${pname}";
    homepage = "https://github.com/hans-chrstn/fonts/releases/tag/Public";
    license = lib.licenses.unfree;
  };
}

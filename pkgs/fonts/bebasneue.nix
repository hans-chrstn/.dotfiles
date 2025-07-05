{ lib, stdenv, fetchurl, p7zip }:

stdenv.mkDerivation rec {
  pname = "BebasNeue";
  version = "1";

  bebasneue = fetchurl {
    url = "https://dl.dafont.com/dl/?f=bebas_neue";
    sha256 = "sha256-Tgf3A7S7CAZhMnTRHHroYfZWZZMYSY7wtGjbr5Sj4hM=";
  };

  nativeBuildInputs = [ p7zip ];

  dontUnpack = "true";

  installPhase = ''
    mkdir -p $out/share/fonts/opentype/${pname}/
    mkdir -p $out/share/fonts/truetype/${pname}/
    7z x -aoa ${bebasneue}
    mv *.otf $out/share/fonts/opentype/${pname}/
    mv *.ttf $out/share/fonts/truetype/${pname}/

  '';

  meta = {
    description = "${pname}";
    homepage = "https://www.dafont.com";
    license = lib.licenses.unfree;
  };
}

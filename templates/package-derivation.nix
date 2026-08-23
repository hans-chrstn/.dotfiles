{
  lib,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "NEW_PACKAGE_NAME";
  version = "0.1.0";

  dontUnpack = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out"
    runHook postInstall
  '';

  meta = {
    description = "NEW_PACKAGE_NAME";
    license = lib.licenses.unfree;
    platforms = lib.platforms.all;
  };
}

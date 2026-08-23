{
  lib,
  writeShellApplication,
}:
writeShellApplication {
  name = "NEW_PACKAGE_NAME";

  text = ''
    echo "NEW_PACKAGE_NAME"
  '';

  meta = {
    description = "NEW_PACKAGE_NAME";
    license = lib.licenses.mit;
    mainProgram = "NEW_PACKAGE_NAME";
  };
}

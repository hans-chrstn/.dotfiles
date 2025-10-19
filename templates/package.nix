{pkgs, ...}:
pkgs.writeShellApplication {
  name = "NEW_PACKAGE_NAME";
  runtimeInputs = with pkgs; [bash]; # Add deps here

  text = ''
    #!/usr/bin/env bash
    echo "Hello from the NEW_PACKAGE_NAME package!"
  '';
}

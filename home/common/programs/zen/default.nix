{ pkgs, ... }:

let
  # Define the Zen Browser package
  zenBrowser = (let version = "1.0.2-b.2"; in pkgs.appimageTools.wrapType2 {
    inherit version;
    name = "zen"; # This will be the name of the executable in $PATH
    src = pkgs.fetchurl {
      url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen-specific.AppImage";
      hash = "sha256-KmCpVLEA2PJt+opoBA+kbhjAVBCGo5wLc/+4xFzBsaQ=";
    };
  });
in {
  # Add Zen Browser to system packages
  home.packages = [
    zenBrowser
  ];

  # Configure Zen Browser as the default browser
  xdg = {
    enable = true;
    desktopEntries."zen-browser" = {
      name = "Zen Browser";
      genericName = "Web Browser";
      exec = "zen"; # Sets the path to the Zen Browser executable
      terminal = false;
      mimeType = [
        "text/html"
        "text/xml"
      ];
    };
  };
}



{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  name = "default";
  buildInputs = with pkgs; [
    python311
    python311Packages.pip
    glib.dev 
    glib
    libffi.dev  
    libffi  
    harfbuzz.dev
    harfbuzz
    fontconfig.dev
    fontconfig
    gobject-introspection
    gobject-introspection.dev
    pango 
    pango.dev 
    pango.out 
    xmlsec
    python3
    python3Packages.virtualenv
    pkg-config
    libxml2.dev  
    libxml2
    libxslt.dev
    zlib
    openssl
    xcode-install
    gtk3 
  ];

}

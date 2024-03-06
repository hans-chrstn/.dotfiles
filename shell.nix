
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
    rustc
    cargo
    rust-analyzer-unwrapped
    gcc
    deno
    mdbook
    ruby

    
    #waybar dependencies
    gtkmm3
    jsoncpp
    libsigcxx
    fmt
    spdlog
    pipewire 
    libnl 
    libappindicator-gtk3
    libdbusmenu-gtk3 
    libmpdclient 
    libevdev
    upower 
    lutris-free
    cmake
    sndio
    gtk-layer-shell
    meson
    scdoc

    #eww
    pango
    rubyPackages_3_3.gdk_pixbuf2
    cairo
    rubyPackages_3_3.glib2
    libgcc
    glibc

    #lunarvim
    gnumake
    nodejs_21
    ripgrep
  ];

}

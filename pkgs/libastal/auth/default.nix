{ stdenv, fetchFromGitHub, pkgs, ... }:
stdenv.mkDerivation rec {
  name = "astalsh-auth";
  src = fetchFromGitHub {
    repo = "https://github.com/astal-sh/auth/";
    owner = "astal-sh";
    rev = "b35a38aa93670f6be06202f2ad3066a227f0a1b9";
    sha256 = "18qxqd4xfx4mn597324vbr4x7y35p93gr1873g6hb9f4s6kjgrhi";
  };

  nativeBuildInputs = with pkgs; [
    gobject-introspection
    meson
    pkg-config
    ninja
    vala
    unzip
  ];

  buildInputs = with pkgs; [
    glib
    pam
    unzip
  ];

  outputs = [
    "out"
    "dev"
  ];
}

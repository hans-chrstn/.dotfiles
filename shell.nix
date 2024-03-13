
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  name = "default";
  buildInputs = with pkgs; [
    libwebp
  ];

}

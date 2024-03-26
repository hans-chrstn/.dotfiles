
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  name = "default";
  buildInputs = with pkgs; [
    nodejs_21
    nodePackages.eslint

  ];

}

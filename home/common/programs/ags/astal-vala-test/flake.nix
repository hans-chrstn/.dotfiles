{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    astal.url = "github:aylur/astal";
  };

  outputs = {
    self,
    nixpkgs,
    astal,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    devShells.${system} = {
      default = pkgs.mkShell {
        buildInputs = [
          astal.packages.${system}.io
          astal.packages.${system}.astal3
          astal.packages.${system}.apps
          astal.packages.${system}.auth
          astal.packages.${system}.battery
          astal.packages.${system}.bluetooth
          astal.packages.${system}.cava
          astal.packages.${system}.wireplumber
          astal.packages.${system}.greet
          astal.packages.${system}.notifd
          astal.packages.${system}.network
          astal.packages.${system}.powerprofiles
          astal.packages.${system}.river
          astal.packages.${system}.tray
          astal.packages.${system}.mpris
          astal.packages.${system}.hyprland
          (pkgs.writeShellScriptBin "bitchass" ''
            nix build .#default
          '')
        ];
        nativeBuildInputs = with pkgs; [
          meson
          ninja
          pkg-config
          vala
          gobject-introspection
          dart-sass
          glib
        ];
      };
    };
    packages.${system} = {
      default = pkgs.stdenv.mkDerivation {
        name = "simple-bar";
        src = ./.;

        nativeBuildInputs = with pkgs; [
          meson
          ninja
          pkg-config
          vala
          gobject-introspection
          dart-sass
          glib
        ];

        buildInputs = [
          astal.packages.${system}.io
          astal.packages.${system}.astal3
          astal.packages.${system}.apps
          astal.packages.${system}.auth
          astal.packages.${system}.battery
          astal.packages.${system}.bluetooth
          astal.packages.${system}.cava
          astal.packages.${system}.wireplumber
          astal.packages.${system}.greet
          astal.packages.${system}.notifd
          astal.packages.${system}.network
          astal.packages.${system}.powerprofiles
          astal.packages.${system}.river
          astal.packages.${system}.tray
          astal.packages.${system}.mpris
          astal.packages.${system}.hyprland
        ];
      };
    };
  };
}

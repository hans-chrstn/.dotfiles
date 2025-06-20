{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    astal,
    ags
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    libs = with astal.packages.${system}; [
      io
      astal3
      apps
      auth
      battery
      bluetooth
      cava
      wireplumber
      greet
      notifd
      network
      powerprofiles
      river
      tray
      mpris
      hyprland
    ];

    reqs = [
      ags.packages.${system}.default
      pkgs.wrapGAppsHook
      pkgs.gobject-introspection
    ];

  in {
    devShells.${system} = {
      default = pkgs.mkShell {
        buildInputs = libs ++ [
          pkgs.libcava
          pkgs.gvfs
          pkgs.gobject-introspection
          (pkgs.writeShellScriptBin "rundev" ''
            ags run -d . -a $1
          '')
        ];
        nativeBuildInputs = reqs;
      };
    };
  };
}

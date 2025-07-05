{ pkgs, ... }:
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # common requirement for several games
      stdenv.cc.cc
      stdenv.cc.cc.lib

      # # from https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/games/steam/fhsenv.nix#L72-L79
      # xorg.libX11
      # xorg.libXScrnSaver
      # xorg.libXcomposite
      # xorg.libXcursor
      # xorg.libXdamage
      # xorg.libXext
      # xorg.libXfixes
      # xorg.libXi
      # xorg.libXrandr
      # xorg.libXrender
      # xorg.libXtst
      # xorg.libxcb
      # xorg.libxkbfile
      # xorg.libxshmfence
      # xorg.libXt
      # xorg.libXmu
      # xorg.libICE
      # libGL
      # libglvnd
      # libnotify
      # #libpulseaudio
      # libunwind
      # libusb1
      # libuuid
      # libxkbcommon
      # libxml2
      # libva
      # libogg
      # libvorbis
      # libdrm
      # libidn
      # libappindicator-gtk3
      #
      # # from https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/games/steam/fhsenv.nix#L124-L136
      # fontconfig
      # freetype
      # SDL
      # SDL2_image
      # glew110
      # tbb
      # zlib
      # fuse3
      # icu
      # nss
      # nspr
      # mesa
      # openssl
      # curl
      # expat
      # systemd
      # vulkan-loader
      # pango
      # pipewire
      # gtk3
      # glib
      # glibc
      # gdk-pixbuf
      # dbus
      # cups
      # cairo
      # atk
      # at-spi2-core
      # at-spi2-atk
      # #alsa-lib
      # 
    ];
  };

}

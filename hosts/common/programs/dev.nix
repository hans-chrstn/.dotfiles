{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ 
    # DEV ENV
    (python3.withPackages(ps: with ps; [
      pip
      tkinter
      debugpy
    ])) 
    (lua.withPackages(ls: with ls; [
      luarocks
    ]))
    luajit
    gnumake 
    nodejs
    nodePackages.sass
    eslint_d
    typescript
    bun
    sassc
    clang-tools
    clang
    gcc
    cl
    zig
    jansson
    cmake
    pkg-config

    qt6.full
  ];
}

{
  nixos = {
    zfs = import ./nixos/zfs;
    btrfs = import ./nixos/btrfs;
    secureboot = import ./nixos/secureboot;
    bluetooth = import ./nixos/bluetooth;
    audio = import ./nixos/audio;
    nvidia = import ./nixos/nvidia;
    amd = import ./nixos/amd;
    intel = import ./nixos/intel;
    nix-ld = import ./nixos/nix-ld;
    steam = import ./nixos/steam;
    via = import ./nixos/via;
    dbus = import ./nixos/dbus;
    sunshine = import ./nixos/sunshine;
    location = import ./nixos/location;
    greetd = import ./nixos/greetd;
    clamav = import ./nixos/clamav;
    monitors = import ./nixos/monitors;
    niri = import ./nixos/niri;
    virtualize = import ./nixos/virtualize;
    godot = import ./nixos/godot;
    ssh = import ./nixos/ssh;
    common-universal = import ./nixos/common-universal;
    common-linux = import ./nixos/common-linux;
  };

  home-manager = {
    nixvim = import ./home-manager/nixvim;
    zsh = import ./home-manager/zsh;
    yazi = import ./home-manager/yazi;
    obs = import ./home-manager/obs;
    niri = import ./home-manager/niri;
    theme = import ./home-manager/theme;
    pentest = import ./home-manager/pentest;
    nix-index = import ./home-manager/nix-index;
    gaming = import ./home-manager/gaming;
    direnv = import ./home-manager/direnv;
    dconf = import ./home-manager/dconf;
    camera = import ./home-manager/camera;
    wezterm = import ./home-manager/wezterm;
    kitty = import ./home-manager/kitty;
    zen = import ./home-manager/zen;
    vscode = import ./home-manager/vscode;
    unity = import ./home-manager/unity;
    neovim = import ./home-manager/neovim;
    neofetch = import ./home-manager/neofetch;
    mpv = import ./home-manager/mpv;
    minecraft = import ./home-manager/minecraft;
    lazygit = import ./home-manager/lazygit;
    joplin = import ./home-manager/joplin;
    git = import ./home-manager/git;
    cava = import ./home-manager/cava;
    btop = import ./home-manager/btop;
  };
}

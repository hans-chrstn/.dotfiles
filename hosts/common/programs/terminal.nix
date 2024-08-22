{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ 
    # TERMINALS
    kitty
    wezterm
    konsole
    neovim
    # EXTRAPKGS
    xclip
    wl-clipboard
    tree-sitter
    stylua
  ];
}

# Add your reusable home-manager modules to this directory, on their own file (https:/nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  btop = import ./apps/btop;
  camera = import ./utils/camera;
  dconf = import ./utils/dconf;
  direnv = import ./utils/direnv;
  emacs = import ./terminal/emacs;
  firefox = import ./browsers/firefox;
  fuzzel = import ./apps/fuzzel;
  gaming = import ./utils/gaming;
  git = import ./apps/git;
  hypridle = import ./apps/hypridle;
  hyprland = import ./wm/hyprland;
  hyprlock = import ./apps/hyprlock;
  hyprpaper = import ./apps/hyprpaper;
  joplin = import ./apps/joplin;
  kitty = import ./terminal/kitty;
  lazygit = import ./apps/lazygit;
  minecraft = import ./apps/minecraft;
  mpv = import ./apps/mpv;
  ncspot = import ./apps/ncspot;
  index = import ./utils/nix-index;
  pentest = import ./utils/pentest;
  spicetify = import ./apps/spicetify;
  swww = import ./apps/swww;
  theme = import ./utils/theme;
  vivaldi = import ./apps/vivaldi;
  vscode = import ./apps/vscode;
  yt-dlp = import ./apps/yt-dlp;
  zen = import ./browsers/zen;
  zed = import ./apps/zed;
}

# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  btop = import ./btop.nix;
  camera = import ./camera.nix;
  dconf = import ./dconf.nix;
  direnv = import ./direnv.nix;
  emacs = import ./emacs.nix;
  firefox = import ./firefox.nix;
  fuzzel = import ./fuzzel.nix;
  gaming = import ./gaming.nix;
  git = import ./git.nix;
  hypridle = import ./hypridle.nix;
  hyprland = import ./hyprland.nix;
  hyprlock = import ./hyprlock.nix;
  hyprpaper = import ./hyprpaper.nix;
  kitty = import ./kitty.nix;
  lazygit = import ./lazygit.nix;
  minecraft = import ./minecraft.nix;
  mpv = import ./mpv.nix;
  nix-index = import ./nix-index.nix;
  pentest = import ./pentest.nix;
  swww = import ./swww.nix;
  theme = import ./theme.nix;
  vivaldi = import ./vivaldi.nix;
  vscodium = import ./vscodium.nix;
  yt-dlp = import ./yt-dlp.nix;
}

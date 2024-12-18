{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  name = "render-markdown";
  src = fetchFromGitHub {
    owner = "MeanderingProgrammer";
    repo = "render-markdown.nvim";
    rev = "main";
    hash = "sha256-8xt2bjdNqMU3Um1mFDpUPEzQtUzwgBYv6nRw2tkKL8k=";
  };
}

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
    hash = "sha256-K2YbO4vIjVgYrWF4MVxqiaTmONF1ZvMXxZVIW/UYwRo=";
  };
}

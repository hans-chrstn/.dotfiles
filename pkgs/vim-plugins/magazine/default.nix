{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  name = "magazine";
  src = fetchFromGitHub {
    owner = "iguanacucumber";
    repo = "magazine.nvim";
    rev = "main";
    hash = "sha256-Yzzv5ZVuKfm+D4V9T/2T59PMoMbPutdt7TNQf4ktjJw=";
  };
}


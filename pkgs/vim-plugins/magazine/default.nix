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
    hash = "sha256-CtOdwYlkYWQ3YEk66tWlwA8dEpL6kYaRHt9d9QnDli4=";
  };
}


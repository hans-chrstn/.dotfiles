{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  name = "drop";
  src = fetchFromGitHub {
    owner = "folke";
    repo = "drop.nvim";
    rev = "main";
    hash = "sha256-UZ7060Fw9oTib1xJuMreBmpl5V9zEw0tYynwsasvLXw=";
  };
}


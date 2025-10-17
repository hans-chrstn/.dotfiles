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
    hash = "sha256-DV9VE/F3GVxfcW0I2qfvttTMVYW1GWawf667xthxJWE=";
  };
}


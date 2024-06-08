{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      nerdFontsVersion = 3;
      border = "rounded";
      keybinding.universal = {
        pullFiles = "<c-p>";
      };
    };
  };
}

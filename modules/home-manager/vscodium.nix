{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.vscodium;
in
{
  options.mod.vscodium = {
    enable = mkEnableOption "Enable vscodium config and it's best values";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc-icons
        catppuccin.catppuccin-vsc
        vscodevim.vim

        github.vscode-pull-request-github

        formulahendry.code-runner

        jnoortheen.nix-ide

        llvm-vs-code-extensions.vscode-clangd
        ms-vscode.cpptools-extension-pack
        ms-vscode.cmake-tools

        rust-lang.rust-analyzer
      ];

      userSettings = {
        "workbench.colorTheme" = "Catppuccin Mocha";
        "window.menuBarVisibility" = "toggle";
        "workbench.startupEditor" = "none";
        "code-runner.runInTerminal" = true;
      };
    };
  };
}

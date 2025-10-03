{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.vscode;
in
{
  options.mod.vscode = {
    enable = mkEnableOption "Enable vscode config and it's best values";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc-icons
        catppuccin.catppuccin-vsc
        vscodevim.vim

        github.vscode-pull-request-github

        formulahendry.code-runner

        jnoortheen.nix-ide

        rust-lang.rust-analyzer

        ms-dotnettools.csharp
        ms-dotnettools.vscodeintellicode-csharp
        ms-dotnettools.vscode-dotnet-runtime
        ms-dotnettools.csdevkit
        csharpier.csharpier-vscode

        arrterian.nix-env-selector

        geequlim.godot-tools

        visualstudiotoolsforunity.vstuc
      ];

      profiles.default.userSettings = {
        "workbench.colorTheme" = "Catppuccin Mocha";
        "window.menuBarVisibility" = "toggle";
        "workbench.startupEditor" = "none";
        "code-runner.runInTerminal" = true;
        "code-runner.executorMap" = {
          rust = "cargo run";
        };
        "workbench.sideBar.location" = "left";
      };
    };
    home.packages = with pkgs; [
      gdb
      csharpier
    ];
  };
}

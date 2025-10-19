{ inputs, lib, config, ... }:
let
  cfg = config.mod.programs.nixvim;
in
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  options.mod.programs.nixvim = {
    enable = lib.mkEnableOption "Enable the nixvim feature";
    # enableXserver = lib.mkOption { type = lib.types.bool; default = true; };
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      vimdiffAlias = true;
      colorschemes.catppuccin = {
        enable = true;
        settings = {
          no_bold = false;
          no_italic = false;
          no_underline = false;
          transparent_background = false;
          integrations = {
            neotree = true;
            gitsigns = true;
            treesitter = true;
            treesitter_context = true;
            telescope.enabled = true;
            cmp = true;
            native_lsp = {
              enabled = true;
              inlay_hints = {
                background = true;
              };
              underlines = {
                errors = ["underline"];
                hints = ["underline"];
                information = ["underline"];
                warnings = ["underline"];
              };
            };
          };
        };
      };

      plugins = {
        lualine.enable = true;
        trouble.enable = true;
        bufferline.enable = true;
        oil.enable = true;
        treesitter.enable = true;
        ts-autotag.enable = true;
        nix.enable = true;
        nvim-autopairs.enable = true;
        cmp.enable = true;
        cmp-nvim-lsp.enable = true;
        cmp-buffer.enable = true;
        cmp-path.enable = true;
        cmp-cmdline.enable = true;

        comment = {
          enable = true;
          settings.sticky = true;
        };

        toggleterm = {
          enable = true;
          settings = {
            hide_numbers = true;
            autochdir = true;
            close_on_exit = true;
            direction = "vertical";
          };
        };

        markdown-preview = {
          enable = true;
          settings.them = "dark";
        };

        gitsigns = {
          enable = true;
          settings.current_line_blame = true;
        };

        lsp = {
          enable = true;
          servers = {
            tsserver.enable = true;
            lua-ls = {
              enable = true;
              settings.telemetry.enable = false;
            };
            nil-ls.enable = true;
            cssls.enable = true;
            html.enable = true;
            astro.enable = true;
            phpactor.enable = true;
            svelte.enable = true;
            vuels.enable = true;
            marksman.enable = true;
            dockerls.enable = true;
            clangd.enable = true;
            bashls.enable = true;
            csharp-ls.enable = true;
            pyright.enable = true;
            rust-analyzer = {
              enable = true;
              installRustc = true;
              installCargo = true;
            };
          };
        };

        lazy = {
          enable = true;
          plugins = [
          ];
        };

        # Good old Telescope
        telescope = {
          enable = true;
          extensions = {
            fzf-native = {
              enable = true;
            };
          };
        };

        neo-tree = {
          enable = true;
          enableDiagnostics = true;
          enableGitStatus = true;
          enableModifiedMarkers = true;
          enableRefreshOnWrite = true;
          closeIfLastWindow = true;
          popupBorderStyle = "rounded"; # Type: null or one of “NC”, “double”, “none”, “rounded”, “shadow”, “single”, “solid” or raw lua code
          buffers = {
            bindToCwd = false;
            followCurrentFile = {
              enabled = true;
            };
          };
          window = {
            width = 40;
            height = 15;
            autoExpandWidth = false;
            mappings = {
              "<space>" = "none";
            };
          };
        };
      };
    };
  };
}

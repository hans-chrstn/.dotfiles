{
  lib,
  config,
  ...
}: let
  cfg = config.mod.programs.yazi;
in {
  options.mod.programs.yazi = {
    enable = lib.mkEnableOption "Enable the yazi feature";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile = {
      "yazi/init.lua" = {
        source = ./config/init.lua;
      };
    };

    programs.yazi = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      shellWrapperName = "yy";
      settings = {
        log = {
          enabled = false;
        };

        mgr = {
          show_hidden = true;
          sort_by = "alphabetical";
          sort_dir_first = true;
          sort_translit = false;
          show_symlink = true;
          linemode = "mtime";
          mouse_events = [
            "click"
            "scroll"
            "drag"
          ];
          ratio = [1 5 2];
        };

        preview = {
          wrap = "no";
        };

        tasks = {
          micro_workers = 10;
          macro_workers = 25;
          bizarre_retry = 5;
          image_alloc = 536870912;
          image_bound = [0 0];
          suppress_preload = false;
        };

        confirm = {
          trash_title = "Trash {n} selected file{s}?";
          trash_origin = "center";
          trash_offset = [0 0 70 20];

          delete_title = "Permanently delete {n} selected file{s}?";
          delete_origin = "center";
          delete_offset = [0 0 70 20];

          overwrite_title = "Overwrite file?";
          overwrite_content = "Will overwrite the following file:";
          overwrite_origin = "center";
          overwrite_offset = [0 0 50 15];

          quit_title = "Quit?";
          quit_content = "The following task is still running, are you sure you want to quit?";
          quit_origin = "center";
          quit_offset = [0 1 50 7];
        };

        select = {
          open_title = "Open with:";
          open_origin = "hovered";
          open_offset = [0 1 50 7];
        };

        which = {
          sort_by = "none";
          sort_sensitive = false;
          sort_reverse = false;
          sort_translit = false;
        };
      };

      keymap = {
        mgr.keymap = [
          # Go to
          {
            run = "cd ~";
            on = ["g" "c" "d"];
            desc = "Go to home directory";
          }
          {
            run = "cd ~/.config";
            on = ["g" "c" "c"];
            desc = "";
          }
          {
            run = "cd ~/.dotfiles";
            on = ["g" "d" "d"];
            desc = "Go to .dotfiles";
          }
          {
            run = "cd ~/.fonts";
            on = ["g" "f" "f"];
            desc = "Go to .fonts";
          }
          {
            run = "cd ~/.local/share/Trash";
            on = ["g" "<S-t>"];
            desc = "Go to .trash";
          }
          {
            run = "cd ~/.wallpapers";
            on = ["g" "w"];
            desc = "Go to .wallpapers";
          }
          {
            run = "cd ~/Downloads";
            on = ["g" "<S-d>"];
            desc = "Go to Downloads";
          }
          {
            run = "cd ~/Documents";
            on = ["g" "d" "c"];
            desc = "Go to Documents";
          }
          {
            run = "cd ~/Pictures";
            on = ["g" "p" "p"];
            desc = "Go to Pictures";
          }
          {
            run = "cd ~/Projects";
            on = ["g" "<S-p>"];
            desc = "Go to Projects";
          }
          {
            run = "cd ~/Pictures/Screenshots";
            on = ["g" "p" "s"];
            desc = "Go to Screenshots";
          }
          {
            run = "cd ~/Videos";
            on = ["g" "v"];
            desc = "Go to Videos";
          }

          # Tabs
          {
            run = "tab_create --current";
            on = "<C-t>";
            desc = "Create new tab";
          }
          {
            run = "close";
            on = "<C-x>";
            desc = "Create new tab";
          }
          {
            run = "tab_switch 0";
            on = "1";
            desc = "Switch to the first tab";
          }
          {
            run = "tab_switch 1";
            on = "2";
            desc = "Switch to the second tab";
          }
          {
            run = "tab_switch 2";
            on = "3";
            desc = "Switch to the third tab";
          }
          {
            run = "tab_switch 3";
            on = "4";
            desc = "Switch to the fourth tab";
          }
          {
            run = "tab_switch 4";
            on = "5";
            desc = "Switch to the fifth tab";
          }
          {
            run = "tab_switch 5";
            on = "6";
            desc = "Switch to the sixth tab";
          }
          {
            run = "tab_switch 6";
            on = "7";
            desc = "Switch to the seventh tab";
          }
          {
            run = "tab_switch 7";
            on = "8";
            desc = "Switch to the eighth tab";
          }
          {
            run = "tab_switch 8";
            on = "9";
            desc = "Switch to the ninth tab";
          }
          {
            run = "tab_switch -1 --relative";
            on = "[";
            desc = "Switch to the previous tab";
          }
          {
            run = "tab_switch 1 --relative";
            on = "]";
            desc = "Switch to the next tab";
          }
          {
            run = "tab_swap -1";
            on = "{";
            desc = "Swap current tab with previous tab";
          }
          {
            run = "tab_swap 1";
            on = "}";
            desc = "Swap current tab with next tab";
          }

          # Tasks
          {
            run = "show";
            on = ["t" "s"];
            desc = "Show task manager";
          }
          {
            run = "inspect";
            on = ["t" "i"];
            desc = "Inspect the task log";
          }
          # Help
          {
            run = "help";
            on = "<F1>";
            desc = "Open help";
          }

          # Misc
          {
            run = "quit";
            on = "q";
            desc = "Exit explorer";
          }
          {
            run = "hidden toggle";
            on = ".";
            desc = "Toggle visibility of hidden files";
          }

          # Shell
          {
            run = "shell --interactive";
            on = ";";
            desc = "Run a shell command";
          }
          {
            run = "shell --block --interactive";
            on = ":";
            desc = "Run a shell command (block until finishes)";
          }

          # Search | Find | Filter
          {
            run = "search fd";
            on = ["f" "d"];
            desc = "Search files by name using fd";
          }
          {
            run = "search rg";
            on = ["f" "g"];
            desc = "Search files by content using ripgrep";
          }
          {
            run = "plugin fzf";
            on = ["f" "z"];
            desc = "Jump to a directory or reveal a file using fzf";
          }
          {
            run = "find --smart";
            on = "/";
            desc = "Find next file";
          }
          {
            run = "find --previous --smart";
            on = "?";
            desc = "Find previous file";
          }
          {
            run = "find_arrow";
            on = ["f" "n"];
            desc = "Go to the next found";
          }
          {
            run = "find_arrow --previous";
            on = ["f" "<S-n>"];
            desc = "Go to the previous found";
          }
          {
            run = "filter --smart";
            on = ["f" "f"];
            desc = "Filter files";
          }

          # Seek
          {
            run = "seek -5";
            on = "<S-k>";
            desc = "Seek up 5 units in preview";
          }
          {
            run = "seek 5";
            on = "<S-j>";
            desc = "Seek down 5 units in preview";
          }

          # Selection
          {
            run = "visual_mode";
            on = "v";
            desc = "Enter visual mode";
          }
          {
            run = "visual_mode --unset";
            on = "<S-v>";
            desc = "Enter visual mode";
          }
          {
            run = "toggle_all --state=on";
            on = "<C-a>";
            desc = "Select all";
          }
          {
            run = "toggle_all --state=off";
            on = "<C-r>";
            desc = "Unselect all";
          }

          # Navigation
          {
            run = "leave";
            on = "h";
            desc = "Move right";
          }
          {
            run = "enter";
            on = "l";
            desc = "Move left";
          }
          {
            run = "arrow -1";
            on = "k";
            desc = "Move up";
          }
          {
            run = "arrow 1";
            on = "j";
            desc = "Move down";
          }
          {
            run = "leave";
            on = "<Left>";
            desc = "Move left";
          }
          {
            run = "enter";
            on = "<Right>";
            desc = "Move right";
          }
          {
            run = "arrow -1";
            on = "<Up>";
            desc = "Move up";
          }
          {
            run = "arrow 1";
            on = "<Down>";
            desc = "Move down";
          }
          {
            run = "arrow -50%";
            on = "<C-k>";
            desc = "Move down by half";
          }
          {
            run = "arrow 50%";
            on = "<C-j>";
            desc = "Move up by half";
          }
          {
            run = "arrow top";
            on = ["g" "g"];
            desc = "Move to top";
          }
          {
            run = "arrow bot";
            on = "<S-g>";
            desc = "Move to bottom";
          }

          # Copy | Cut | Delete | Create | Rename | Filter | Open
          {
            run = "open";
            on = ["e" "e"];
            desc = "Open selected file(s)";
          }
          {
            run = "open --interactive";
            on = ["e" "<S-e>"];
            desc = "Open selected file(s) interactively";
          }
          {
            run = "yank";
            on = ["y" "y"];
            desc = "Copy file(s)";
          }
          {
            run = "unyank";
            on = "<C-y>";
            desc = "Uncopy/cut the file(s)";
          }
          {
            run = "yank --cut";
            on = ["d" "d"];
            desc = "Cut file(s)";
          }
          {
            run = "copy path";
            on = ["c" "c"];
            desc = "Copy the file path";
          }
          {
            run = "copy dirname";
            on = ["c" "p"];
            desc = "Copy the file directory path";
          }
          {
            run = "copy filename";
            on = ["c" "f"];
            desc = "Copy the filename";
          }
          {
            run = "copy name_without_ext";
            on = ["c" "n"];
            desc = "Copy the filename without the extension";
          }
          {
            run = "paste";
            on = ["p" "p"];
            desc = "Paste file(s)";
          }
          {
            run = "paste --force";
            on = ["p" "<S-p>"];
            desc = "Overwrite paste file(s)";
          }
          {
            run = "remove";
            on = ["d" "t"];
            desc = "Trash selected file(s)";
          }
          {
            run = "remove --permanently";
            on = ["d" "<S-d>"];
            desc = "Delete selected file(s)";
          }
          {
            run = "create";
            on = ["m" "k"];
            desc = "Create a file (ends with / for directories)";
          }
          {
            run = "rename --cursor=before_ext";
            on = ["r" "r"];
            desc = "Rename selected file(s)";
          }
          {
            run = "shell -- zip -r .zip \"$0\"";
            on = "<S-z>";
            desc = "Zip a file";
          }
          {
            run = "shell -- unzip -o -q \"$0\"";
            on = ["u" "z"];
            desc = "Unzip a file";
          }

          # Sorting
          {
            run = ["sort modified --reverse=no" "linemode mtime"];
            on = ["\\" "m"];
            desc = "Sort by modified time";
          }
          {
            run = ["sort modified --reverse" "linemode mtime"];
            on = ["\\" "<S-m>"];
            desc = "Sort by modified time (reverse)";
          }
          {
            run = ["sort created --reverse=no" "linemode ctime"];
            on = ["\\" "c"];
            desc = "Sort by created time";
          }
          {
            run = ["sort created --reverse" "linemode ctime"];
            on = ["\\" "<S-c>"];
            desc = "Sort by created time (reverse)";
          }
          {
            run = "sort extension --reverse=no";
            on = ["\\" "e"];
            desc = "Sort by extension";
          }
          {
            run = "sort extension --reverse";
            on = ["\\" "<S-e>"];
            desc = "Sort by extension (reverse)";
          }
          {
            run = "sort alphabetical --reverse=no";
            on = ["\\" "a"];
            desc = "Sort alphabetically";
          }
          {
            run = "sort alphabetical --reverse";
            on = ["\\" "<S-a>"];
            desc = "Sort alphabetically (reverse)";
          }
          {
            run = "sort natural --reverse=no";
            on = ["\\" "j"];
            desc = "Sort naturally";
          }
          {
            run = "sort natural --reverse";
            on = ["\\" "<S-j>"];
            desc = "Sort naturally (reverse)";
          }
          {
            run = ["sort size --reverse=no" "linemode size"];
            on = ["\\" "s"];
            desc = "Sort by size";
          }
          {
            run = ["sort size --reverse" "linemode size"];
            on = ["\\" "<S-s>"];
            desc = "Sort by size (reverse)";
          }
          {
            run = "sort random --reverse=no";
            on = ["\\" "r"];
            desc = "Sort randomly";
          }
        ];
      };

      theme = {
        mgr = {
          # Hovered
          hovered = {
          };
          preview_hovered = {underline = true;};
          # Find
          find_keyword = {
            italic = true;
          };
          find_position = {
            italic = true;
          };

          # Marker
          marker_copied = {
          };
          marker_cut = {
          };
          marker_selected = {
          };

          # Tab
          tab_active = {
          };
          tab_inactive = {
          };
          tab_width = 1;

          # Count
          count_copied = {
          };
          count_cut = {
          };
          count_selected = {
          };

          # Border
          border_symbol = "│";
        };

        status = {
          separator_open = "";
          separator_close = "";
          separator_style = {
          };

          # Mode
          mode_normal = {
            bold = true;
          };
          mode_select = {
            bold = true;
          };
          mode_unset = {
            bold = true;
          };

          # Progress
          progress_label = {
            bold = true;
          };
          progress_normal = {
          };
          progress_error = {
          };
        };

        input = {
          title = {};
          value = {};
          selected = {reversed = true;};
        };

        select = {
          inactive = {};
        };

        tasks = {
          title = {};
          hovered = {underline = true;};
        };

        which = {
          separator = "  ";
        };

        help = {
          hovered = {
            bold = true;
          };
          footer = {
          };
        };
        filetype = {
          rules = [
            # Media
            {
              mime = "image/*";
            }
            {
              mime = "{audio,video}/*";
            }

            # Archives
            {
              mime = "application/{,g}zip";
            }
            {
              mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}";
            }

            # Fallback
            {
              name = "*";
            }
            {
              name = "*/";
            }
          ];
        };

        icon = {
          files = [
            {
              name = "gulpfile.js";
              text = "";
            }
            {
              name = ".babelrc";
              text = "";
            }
            {
              name = "copying.lesser";
              text = "";
            }
            {
              name = ".npmrc";
              text = "";
            }
            {
              name = "docker-compose.yml";
              text = "󰡨";
            }
            {
              name = "svelte.config.js";
              text = "";
            }
            {
              name = "copying";
              text = "";
            }
            {
              name = "prettier.config.ts";
              text = "";
            }
            {
              name = "gruntfile.babel.js";
              text = "";
            }
            {
              name = ".SRCINFO";
              text = "󰣇";
            }
            {
              name = ".xinitrc";
              text = "";
            }
            {
              name = "docker-compose.yaml";
              text = "󰡨";
            }
            {
              name = "nuxt.config.ts";
              text = "󱄆";
            }
            {
              name = "build";
              text = "";
            }
            {
              name = ".editorconfig";
              text = "";
            }
            {
              name = "nuxt.config.mjs";
              text = "󱄆";
            }
            {
              name = ".gitlab-ci.yml";
              text = "";
            }
            {
              name = "PKGBUILD";
              text = "";
            }
            {
              name = ".bash_profile";
              text = "";
            }
            {
              name = ".bashrc";
              text = "";
            }
            {
              name = "compose.yml";
              text = "󰡨";
            }
            {
              name = "eslint.config.cjs";
              text = "";
            }
            {
              name = "go.mod";
              text = "";
            }
            {
              name = ".mailmap";
              text = "󰊢";
            }
            {
              name = "gtkrc";
              text = "";
            }
            {
              name = "go.work";
              text = "";
            }
            {
              name = "justfile";
              text = "";
            }
            {
              name = "kritadisplayrc";
              text = "";
            }
            {
              name = "commitlint.config.js";
              text = "󰜘";
            }
            {
              name = ".env";
              text = "";
            }
            {
              name = "PrusaSlicerGcodeViewer.ini";
              text = "";
            }
            {
              name = "r";
              text = "󰟔";
            }
            {
              name = "license";
              text = "";
            }
            {
              name = ".gitignore";
              text = "";
            }
            {
              name = "tailwind.config.js";
              text = "󱏿";
            }
            {
              name = ".prettierrc.yml";
              text = "";
            }
            {
              name = ".zprofile";
              text = "";
            }
            {
              name = ".zshenv";
              text = "";
            }
            {
              name = "xmonad.hs";
              text = "";
            }
            {
              name = ".eslintignore";
              text = "";
            }
            {
              name = "tsconfig.json";
              text = "";
            }
            {
              name = ".prettierrc.json5";
              text = "";
            }
            {
              name = ".ds_store";
              text = "";
            }
            {
              name = "gulpfile.coffee";
              text = "";
            }
            {
              name = "R";
              text = "󰟔";
            }
            {
              name = ".zshrc";
              text = "";
            }
            {
              name = ".prettierrc.toml";
              text = "";
            }
            {
              name = ".gvimrc";
              text = "";
            }
            {
              name = ".xsession";
              text = "";
            }
            {
              name = ".justfile";
              text = "";
            }
            {
              name = ".gitconfig";
              text = "";
            }
            {
              name = "gradle-wrapper.properties";
              text = "";
            }
            {
              name = "ionic.config.json";
              text = "";
            }
            {
              name = "cantorrc";
              text = "";
            }
            {
              name = ".gleam";
              text = "";
            }
            {
              name = "package-lock.json";
              text = "";
            }
            {
              name = "package.json";
              text = "";
            }
            {
              name = "hyprland.conf";
              text = "";
            }
            {
              name = "gulpfile.babel.js";
              text = "";
            }
            {
              name = ".nvmrc";
              text = "";
            }
            {
              name = ".prettierignore";
              text = "";
            }
            {
              name = "ext_typoscript_setup.txt";
              text = "";
            }
            {
              name = "QtProject.conf";
              text = "";
            }
            {
              name = "avif";
              text = "";
            }
            {
              name = "mix.lock";
              text = "";
            }
            {
              name = "build.gradle";
              text = "";
            }
            {
              name = "gemfile$";
              text = "";
            }
            {
              name = ".vimrc";
              text = "";
            }
            {
              name = "i18n.config.ts";
              text = "󰗊";
            }
            {
              name = "gulpfile.ts";
              text = "";
            }
            {
              name = "build.zig.zon";
              text = "";
            }
            {
              name = "checkhealth";
              text = "󰓙";
            }
            {
              name = "xmobarrc";
              text = "";
            }
            {
              name = "_vimrc";
              text = "";
            }
            {
              name = ".luaurc";
              text = "";
            }
            {
              name = "kdenlive-layoutsrc";
              text = "";
            }
            {
              name = "gradlew";
              text = "";
            }
            {
              name = "xsettingsd.conf";
              text = "";
            }
            {
              name = "vlcrc";
              text = "󰕼";
            }
            {
              name = "xorg.conf";
              text = "";
            }
            {
              name = "xmobarrc.hs";
              text = "";
            }
            {
              name = "workspace";
              text = "";
            }
            {
              name = ".gitattributes";
              text = "";
            }
            {
              name = "favicon.ico";
              text = "";
            }
            {
              name = "go.sum";
              text = "";
            }
            {
              name = "pom.xml";
              text = "";
            }
            {
              name = "webpack";
              text = "󰜫";
            }
            {
              name = "vagrantfile$";
              text = "";
            }
            {
              name = "unlicense";
              text = "";
            }
            {
              name = "tmux.conf.local";
              text = "";
            }
            {
              name = "settings.gradle";
              text = "";
            }
            {
              name = ".dockerignore";
              text = "󰡨";
            }
            {
              name = "sym-lib-table";
              text = "";
            }
            {
              name = "_gvimrc";
              text = "";
            }
            {
              name = "kdenliverc";
              text = "";
            }
            {
              name = "kdeglobals";
              text = "";
            }
            {
              name = ".prettierrc.yaml";
              text = "";
            }
            {
              name = "rmd";
              text = "";
            }
            {
              name = "tailwind.config.mjs";
              text = "󱏿";
            }
            {
              name = "sxhkdrc";
              text = "";
            }
            {
              name = "robots.txt";
              text = "󰚩";
            }
            {
              name = "tailwind.config.ts";
              text = "󱏿";
            }
            {
              name = "prettier.config.mjs";
              text = "";
            }
            {
              name = "mpv.conf";
              text = "";
            }
            {
              name = "py.typed";
              text = "";
            }
            {
              name = "PrusaSlicer.ini";
              text = "";
            }
            {
              name = "procfile";
              text = "";
            }
            {
              name = "rakefile";
              text = "";
            }
            {
              name = "kritarc";
              text = "";
            }
            {
              name = ".Xresources";
              text = "";
            }
            {
              name = "prettier.config.js";
              text = "";
            }
            {
              name = "commitlint.config.ts";
              text = "󰜘";
            }
            {
              name = "weston.ini";
              text = "";
            }
            {
              name = "eslint.config.js";
              text = "";
            }
            {
              name = "cmakelists.txt";
              text = "";
            }
            {
              name = ".git-blame-ignore-revs";
              text = "";
            }
            {
              name = "config";
              text = "";
            }
            {
              name = "nuxt.config.cjs";
              text = "󱄆";
            }
            {
              name = "node_modules";
              text = "";
            }
            {
              name = "makefile";
              text = "";
            }
            {
              name = "lxqt.conf";
              text = "";
            }
            {
              name = "i18n.config.js";
              text = "󰗊";
            }
            {
              name = "FreeCAD.conf";
              text = "";
            }
            {
              name = "prettier.config.cjs";
              text = "";
            }
            {
              name = "tmux.conf";
              text = "";
            }
            {
              name = "kalgebrarc";
              text = "";
            }
            {
              name = "i3status.conf";
              text = "";
            }
            {
              name = ".settings.json";
              text = "";
            }
            {
              name = "containerfile";
              text = "󰡨";
            }
            {
              name = "i3blocks.conf";
              text = "";
            }
            {
              name = "lxde-rc.xml";
              text = "";
            }
            {
              name = "gradle.properties";
              text = "";
            }
            {
              name = "hypridle.conf";
              text = "";
            }
            {
              name = "gruntfile.ts";
              text = "";
            }
            {
              name = "gruntfile.js";
              text = "";
            }
            {
              name = "dockerfile";
              text = "󰡨";
            }
            {
              name = "groovy";
              text = "";
            }
            {
              name = "hyprlock.conf";
              text = "";
            }
            {
              name = ".prettierrc";
              text = "";
            }
            {
              name = "gnumakefile";
              text = "";
            }
            {
              name = "commit_editmsg";
              text = "";
            }
            {
              name = "fp-lib-table";
              text = "";
            }
            {
              name = "fp-info-cache";
              text = "";
            }
            {
              name = "eslint.config.ts";
              text = "";
            }
            {
              name = "nuxt.config.js";
              text = "󱄆";
            }
            {
              name = "platformio.ini";
              text = "";
            }
            {
              name = ".nuxtrc";
              text = "󱄆";
            }
            {
              name = "gruntfile.coffee";
              text = "";
            }
            {
              name = "eslint.config.mjs";
              text = "";
            }
            {
              name = "compose.yaml";
              text = "󰡨";
            }
            {
              name = "bspwmrc";
              text = "";
            }
            {
              name = "brewfile";
              text = "";
            }
            {
              name = ".eslintrc";
              text = "";
            }
            {
              name = ".gtkrc-2.0";
              text = "";
            }
            {
              name = ".Xauthority";
              text = "";
            }
            {
              name = ".prettierrc.json";
              text = "";
            }
            {
              name = ".npmignore";
              text = "";
            }
            {
              name = ".gitmodules";
              text = "";
            }
          ];

          exts = [
            {
              name = "rake";
              text = "";
            }
            {
              name = "skp";
              text = "󰻫";
            }
            {
              name = "eln";
              text = "";
            }
            {
              name = "razor";
              text = "󱦘";
            }
            {
              name = "vue";
              text = "";
            }
            {
              name = "sln";
              text = "";
            }
            {
              name = "el";
              text = "";
            }
            {
              name = "blp";
              text = "󰺾";
            }
            {
              name = "jl";
              text = "";
            }
            {
              name = "mdx";
              text = "";
            }
            {
              name = "jsx";
              text = "";
            }
            {
              name = "ml";
              text = "";
            }
            {
              name = "less";
              text = "";
            }
            {
              name = "pot";
              text = "";
            }
            {
              name = "pl";
              text = "";
            }
            {
              name = "mli";
              text = "";
            }
            {
              name = "gif";
              text = "";
            }
            {
              name = "aif";
              text = "";
            }
            {
              name = "cxxm";
              text = "";
            }
            {
              name = "fcbak";
              text = "";
            }
            {
              name = "aac";
              text = "";
            }
            {
              name = "query";
              text = "";
            }
            {
              name = "android";
              text = "";
            }
            {
              name = "m3u8";
              text = "󰲹";
            }
            {
              name = "leex";
              text = "";
            }
            {
              name = "liquid";
              text = "";
            }
            {
              name = "cue";
              text = "󰲹";
            }
            {
              name = "fcmacro";
              text = "";
            }
            {
              name = "log";
              text = "󰌱";
            }
            {
              name = "pm";
              text = "";
            }
            {
              name = "brep";
              text = "󰻫";
            }
            {
              name = "blend";
              text = "󰂫";
            }
            {
              name = "md5";
              text = "󰕥";
            }
            {
              name = "sql";
              text = "";
            }
            {
              name = "xcplayground";
              text = "";
            }
            {
              name = "erb";
              text = "";
            }
            {
              name = "t";
              text = "";
            }
            {
              name = "cache";
              text = "";
            }
            {
              name = "r";
              text = "󰟔";
            }
            {
              name = "x";
              text = "";
            }
            {
              name = "import";
              text = "";
            }
            {
              name = "m";
              text = "";
            }
            {
              name = "lrc";
              text = "󰨖";
            }
            {
              name = "o";
              text = "";
            }
            {
              name = "d";
              text = "";
            }
            {
              name = "c";
              text = "";
            }
            {
              name = "h";
              text = "";
            }
            {
              name = "rss";
              text = "";
            }
            {
              name = "hbs";
              text = "";
            }
            {
              name = "godot";
              text = "";
            }
            {
              name = "eot";
              text = "";
            }
            {
              name = "awk";
              text = "";
            }
            {
              name = "fsx";
              text = "";
            }
            {
              name = "a";
              text = "";
            }
            {
              name = "pyi";
              text = "";
            }
            {
              name = "asc";
              text = "󰦝";
            }
            {
              name = "ass";
              text = "󰨖";
            }
            {
              name = "css";
              text = "";
            }
            {
              name = "psb";
              text = "";
            }
            {
              name = "csproj";
              text = "󰪮";
            }
            {
              name = "csv";
              text = "";
            }
            {
              name = "gcode";
              text = "󰐫";
            }
            {
              name = "ics";
              text = "";
            }
            {
              name = "mk";
              text = "";
            }
            {
              name = "bz";
              text = "";
            }
            {
              name = "fctb";
              text = "";
            }
            {
              name = "gz";
              text = "";
            }
            {
              name = "wasm";
              text = "";
            }
            {
              name = "glb";
              text = "";
            }
            {
              name = "elc";
              text = "";
            }
            {
              name = "flf";
              text = "";
            }
            {
              name = "elf";
              text = "";
            }
            {
              name = "dropbox";
              text = "";
            }
            {
              name = "tres";
              text = "";
            }
            {
              name = "apk";
              text = "";
            }
            {
              name = "ape";
              text = "";
            }
            {
              name = "slvs";
              text = "󰻫";
            }
            {
              name = "apl";
              text = "⍝";
            }
            {
              name = "cs";
              text = "󰌛";
            }
            {
              name = "azcli";
              text = "";
            }
            {
              name = "pp";
              text = "";
            }
            {
              name = "flc";
              text = "";
            }
            {
              name = "gemspec";
              text = "";
            }
            {
              name = "pls";
              text = "󰲹";
            }
            {
              name = "cfg";
              text = "";
            }
            {
              name = "fcscript";
              text = "";
            }
            {
              name = "gnumakefile";
              text = "";
            }
            {
              name = "zst";
              text = "";
            }
            {
              name = "pxi";
              text = "";
            }
            {
              name = "woff2";
              text = "";
            }
            {
              name = "kicad_pcb";
              text = "";
            }
            {
              name = "zsh";
              text = "";
            }
            {
              name = "kicad_wks";
              text = "";
            }
            {
              name = "info";
              text = "";
            }
            {
              name = "cppm";
              text = "";
            }
            {
              name = "svg";
              text = "󰜡";
            }
            {
              name = "flac";
              text = "";
            }
            {
              name = "cuh";
              text = "";
            }
            {
              name = "bin";
              text = "";
            }
            {
              name = "zig";
              text = "";
            }
            {
              name = "yml";
              text = "";
            }
            {
              name = "yaml";
              text = "";
            }
            {
              name = "fsscript";
              text = "";
            }
            {
              name = "xz";
              text = "";
            }
            {
              name = "diff";
              text = "";
            }
            {
              name = "mojo";
              text = "";
            }
            {
              name = "cshtml";
              text = "󱦗";
            }
            {
              name = "bak";
              text = "󰁯";
            }
            {
              name = "nfo";
              text = "";
            }
            {
              name = "bat";
              text = "";
            }
            {
              name = "cpy";
              text = "⚙";
            }
            {
              name = "gql";
              text = "";
            }
            {
              name = "c++";
              text = "";
            }
            {
              name = "lff";
              text = "";
            }
            {
              name = "obj";
              text = "󰆧";
            }
            {
              name = "sha512";
              text = "󰕥";
            }
            {
              name = "scm";
              text = "󰘧";
            }
            {
              name = "aiff";
              text = "";
            }
            {
              name = "sig";
              text = "λ";
            }
            {
              name = "webm";
              text = "";
            }
            {
              name = "zip";
              text = "";
            }
            {
              name = "wrz";
              text = "󰆧";
            }
            {
              name = "jwmrc";
              text = "";
            }
            {
              name = "xml";
              text = "󰗀";
            }
            {
              name = "cbl";
              text = "⚙";
            }
            {
              name = "rmd";
              text = "";
            }
            {
              name = "xaml";
              text = "󰙳";
            }
            {
              name = "xm";
              text = "";
            }
            {
              name = "wvc";
              text = "";
            }
            {
              name = "drl";
              text = "";
            }
            {
              name = "erl";
              text = "";
            }
            {
              name = "3gp";
              text = "";
            }
            {
              name = "ccm";
              text = "";
            }
            {
              name = "ino";
              text = "";
            }
            {
              name = "kbx";
              text = "󰯄";
            }
            {
              name = "test.js";
              text = "";
            }
            {
              name = "wrl";
              text = "󰆧";
            }
            {
              name = "pcm";
              text = "";
            }
            {
              name = "woff";
              text = "";
            }
            {
              name = "scala";
              text = "";
            }
            {
              name = "webpack";
              text = "󰜫";
            }
            {
              name = "hrl";
              text = "";
            }
            {
              name = "kra";
              text = "";
            }
            {
              name = "kicad_pro";
              text = "";
            }
            {
              name = "bazel";
              text = "";
            }
            {
              name = "toml";
              text = "";
            }
            {
              name = "iges";
              text = "󰻫";
            }
            {
              name = "crdownload";
              text = "";
            }
            {
              name = "so";
              text = "";
            }
            {
              name = "strings";
              text = "";
            }
            {
              name = "xls";
              text = "󰈛";
            }
            {
              name = "wav";
              text = "";
            }
            {
              name = "vsix";
              text = "";
            }
            {
              name = "kicad_prl";
              text = "";
            }
            {
              name = "mov";
              text = "";
            }
            {
              name = "bash";
              text = "";
            }
            {
              name = "sqlite3";
              text = "";
            }
            {
              name = "vsh";
              text = "";
            }
            {
              name = "vim";
              text = "";
            }
            {
              name = "lck";
              text = "";
            }
            {
              name = "go";
              text = "";
            }
            {
              name = "pyo";
              text = "";
            }
            {
              name = "vhdl";
              text = "󰍛";
            }
            {
              name = "vhd";
              text = "󰍛";
            }
            {
              name = "rar";
              text = "";
            }
            {
              name = "magnet";
              text = "";
            }
            {
              name = "vala";
              text = "";
            }
            {
              name = "coffee";
              text = "";
            }
            {
              name = "kdbx";
              text = "";
            }
            {
              name = "po";
              text = "";
            }
            {
              name = "v";
              text = "󰍛";
            }
            {
              name = "prisma";
              text = "";
            }
            {
              name = "f90";
              text = "󱈚";
            }
            {
              name = "txt";
              text = "󰈙";
            }
            {
              name = "mo";
              text = "∞";
            }
            {
              name = "mp4";
              text = "";
            }
            {
              name = "cljc";
              text = "";
            }
            {
              name = "heex";
              text = "";
            }
            {
              name = "exs";
              text = "";
            }
            {
              name = "clj";
              text = "";
            }
            {
              name = "luau";
              text = "";
            }
            {
              name = "fcparam";
              text = "";
            }
            {
              name = "markdown";
              text = "";
            }
            {
              name = "dxf";
              text = "󰻫";
            }
            {
              name = "luac";
              text = "";
            }
            {
              name = "desktop";
              text = "";
            }
            {
              name = "docx";
              text = "󰈬";
            }
            {
              name = "cljd";
              text = "";
            }
            {
              name = "txz";
              text = "";
            }
            {
              name = "bicepparam";
              text = "";
            }
            {
              name = "kt";
              text = "";
            }
            {
              name = "fcstd";
              text = "";
            }
            {
              name = "md";
              text = "";
            }
            {
              name = "edn";
              text = "";
            }
            {
              name = "sub";
              text = "󰨖";
            }
            {
              name = "ttf";
              text = "";
            }
            {
              name = "tsx";
              text = "";
            }
            {
              name = "hurl";
              text = "";
            }
            {
              name = "dll";
              text = "";
            }
            {
              name = "lhs";
              text = "";
            }
            {
              name = "tsconfig";
              text = "";
            }
            {
              name = "msf";
              text = "";
            }
            {
              name = "ts";
              text = "";
            }
            {
              name = "rproj";
              text = "󰗆";
            }
            {
              name = "org";
              text = "";
            }
            {
              name = "signature";
              text = "λ";
            }
            {
              name = "elm";
              text = "";
            }
            {
              name = "pyc";
              text = "";
            }
            {
              name = "tmux";
              text = "";
            }
            {
              name = "tgz";
              text = "";
            }
            {
              name = "nu";
              text = ">";
            }
            {
              name = "tfvars";
              text = "";
            }
            {
              name = "lua";
              text = "";
            }
            {
              name = "astro";
              text = "";
            }
            {
              name = "lib";
              text = "";
            }
            {
              name = "tex";
              text = "";
            }
            {
              name = "ogg";
              text = "";
            }
            {
              name = "stp";
              text = "󰻫";
            }
            {
              name = "sublime";
              text = "";
            }
            {
              name = "test.tsx";
              text = "";
            }
            {
              name = "nswag";
              text = "";
            }
            {
              name = "test.ts";
              text = "";
            }
            {
              name = "test.jsx";
              text = "";
            }
            {
              name = "dwg";
              text = "󰻫";
            }
            {
              name = "bib";
              text = "󱉟";
            }
            {
              name = "sass";
              text = "";
            }
            {
              name = "templ";
              text = "";
            }
            {
              name = "tcl";
              text = "󰛓";
            }
            {
              name = "pck";
              text = "";
            }
            {
              name = "swift";
              text = "";
            }
            {
              name = "makefile";
              text = "";
            }
            {
              name = "xcstrings";
              text = "";
            }
            {
              name = "slim";
              text = "";
            }
            {
              name = "iso";
              text = "";
            }
            {
              name = "fsi";
              text = "";
            }
            {
              name = "dart";
              text = "";
            }
            {
              name = "nix";
              text = "";
            }
            {
              name = "svelte";
              text = "";
            }
            {
              name = "sv";
              text = "󰍛";
            }
            {
              name = "bz2";
              text = "";
            }
            {
              name = "sha256";
              text = "󰕥";
            }
            {
              name = "twig";
              text = "";
            }
            {
              name = "material";
              text = "󰔉";
            }
            {
              name = "ppt";
              text = "󰈧";
            }
            {
              name = "pyd";
              text = "";
            }
            {
              name = "step";
              text = "󰻫";
            }
            {
              name = "hx";
              text = "";
            }
            {
              name = "webmanifest";
              text = "";
            }
            {
              name = "kicad_sch";
              text = "";
            }
            {
              name = "cjs";
              text = "";
            }
            {
              name = "stl";
              text = "󰆧";
            }
            {
              name = "ejs";
              text = "";
            }
            {
              name = "ssa";
              text = "󰨖";
            }
            {
              name = "license";
              text = "";
            }
            {
              name = "jsonc";
              text = "";
            }
            {
              name = "download";
              text = "";
            }
            {
              name = "ige";
              text = "󰻫";
            }
            {
              name = "sqlite";
              text = "";
            }
            {
              name = "psd1";
              text = "󰨊";
            }
            {
              name = "dump";
              text = "";
            }
            {
              name = "resi";
              text = "";
            }
            {
              name = "spec.ts";
              text = "";
            }
            {
              name = "fnl";
              text = "";
            }
            {
              name = "cu";
              text = "";
            }
            {
              name = "scss";
              text = "";
            }
            {
              name = "config.ru";
              text = "";
            }
            {
              name = "psd";
              text = "";
            }
            {
              name = "db";
              text = "";
            }
            {
              name = "epub";
              text = "";
            }
            {
              name = "haml";
              text = "";
            }
            {
              name = "sol";
              text = "";
            }
            {
              name = "sml";
              text = "λ";
            }
            {
              name = "svh";
              text = "󰍛";
            }
            {
              name = "sldprt";
              text = "󰻫";
            }
            {
              name = "ico";
              text = "";
            }
            {
              name = "xlsx";
              text = "󰈛";
            }
            {
              name = "rs";
              text = "";
            }
            {
              name = "dconf";
              text = "";
            }
            {
              name = "bz3";
              text = "";
            }
            {
              name = "fdmdownload";
              text = "";
            }
            {
              name = "fs";
              text = "";
            }
            {
              name = "patch";
              text = "";
            }
            {
              name = "hs";
              text = "";
            }
            {
              name = "xcf";
              text = "";
            }
            {
              name = "js";
              text = "";
            }
            {
              name = "pyw";
              text = "";
            }
            {
              name = "sha384";
              text = "󰕥";
            }
            {
              name = "fcmat";
              text = "";
            }
            {
              name = "csh";
              text = "";
            }
            {
              name = "suo";
              text = "";
            }
            {
              name = "sha224";
              text = "󰕥";
            }
            {
              name = "sha1";
              text = "󰕥";
            }
            {
              name = "cr";
              text = "";
            }
            {
              name = "huff";
              text = "󰡘";
            }
            {
              name = "sh";
              text = "";
            }
            {
              name = "sc";
              text = "";
            }
            {
              name = "ksh";
              text = "";
            }
            {
              name = "cc";
              text = "";
            }
            {
              name = "wma";
              text = "";
            }
            {
              name = "mp3";
              text = "";
            }
            {
              name = "conf";
              text = "";
            }
            {
              name = "3mf";
              text = "󰆧";
            }
            {
              name = "sbt";
              text = "";
            }
            {
              name = "kicad_mod";
              text = "";
            }
            {
              name = "terminal";
              text = "";
            }
            {
              name = "rlib";
              text = "";
            }
            {
              name = "pdf";
              text = "";
            }
            {
              name = "mts";
              text = "";
            }
            {
              name = "kdenlive";
              text = "";
            }
            {
              name = "kts";
              text = "";
            }
            {
              name = "spec.tsx";
              text = "";
            }
            {
              name = "res";
              text = "";
            }
            {
              name = "hxx";
              text = "";
            }
            {
              name = "rb";
              text = "";
            }
            {
              name = "vh";
              text = "󰍛";
            }
            {
              name = "ixx";
              text = "";
            }
            {
              name = "cson";
              text = "";
            }
            {
              name = "cts";
              text = "";
            }
            {
              name = "7z";
              text = "";
            }
            {
              name = "ex";
              text = "";
            }
            {
              name = "cpp";
              text = "";
            }
            {
              name = "qss";
              text = "";
            }
            {
              name = "app";
              text = "";
            }
            {
              name = "jxl";
              text = "";
            }
            {
              name = "qrc";
              text = "";
            }
            {
              name = "qml";
              text = "";
            }
            {
              name = "epp";
              text = "";
            }
            {
              name = "otf";
              text = "";
            }
            {
              name = "hh";
              text = "";
            }
            {
              name = "qm";
              text = "";
            }
            {
              name = "pro";
              text = "";
            }
            {
              name = "exe";
              text = "";
            }
            {
              name = "kdenlivetitle";
              text = "";
            }
            {
              name = "kdb";
              text = "";
            }
            {
              name = "mpp";
              text = "";
            }
            {
              name = "Dockerfile";
              text = "󰡨";
            }
            {
              name = "bqn";
              text = "⎉";
            }
            {
              name = "torrent";
              text = "";
            }
            {
              name = "m3u";
              text = "󰲹";
            }
            {
              name = "py";
              text = "";
            }
            {
              name = "pxd";
              text = "";
            }
            {
              name = "f3d";
              text = "󰻫";
            }
            {
              name = "out";
              text = "";
            }
            {
              name = "spec.jsx";
              text = "";
            }
            {
              name = "kicad_dru";
              text = "";
            }
            {
              name = "ps1";
              text = "󰨊";
            }
            {
              name = "ui";
              text = "";
            }
            {
              name = "styl";
              text = "";
            }
            {
              name = "f#";
              text = "";
            }
            {
              name = "png";
              text = "";
            }
            {
              name = "ply";
              text = "󰆧";
            }
            {
              name = "php";
              text = "";
            }
            {
              name = "eex";
              text = "";
            }
            {
              name = "tbc";
              text = "󰛓";
            }
            {
              name = "part";
              text = "";
            }
            {
              name = "pub";
              text = "󰷖";
            }
            {
              name = "ipynb";
              text = "";
            }
            {
              name = "opus";
              text = "";
            }
            {
              name = "git";
              text = "";
            }
            {
              name = "bmp";
              text = "";
            }
            {
              name = "blade.php";
              text = "";
            }
            {
              name = "nim";
              text = "";
            }
            {
              name = "xpi";
              text = "";
            }
            {
              name = "mustache";
              text = "";
            }
            {
              name = "tscn";
              text = "";
            }
            {
              name = "scad";
              text = "";
            }
            {
              name = "ai";
              text = "";
            }
            {
              name = "hex";
              text = "";
            }
            {
              name = "hpp";
              text = "";
            }
            {
              name = "xul";
              text = "";
            }
            {
              name = "mobi";
              text = "";
            }
            {
              name = "fcstd1";
              text = "";
            }
            {
              name = "ical";
              text = "";
            }
            {
              name = "icalendar";
              text = "";
            }
            {
              name = "bicep";
              text = "";
            }
            {
              name = "mm";
              text = "";
            }
            {
              name = "mkv";
              text = "";
            }
            {
              name = "graphql";
              text = "";
            }
            {
              name = "mjs";
              text = "";
            }
            {
              name = "mint";
              text = "󰌪";
            }
            {
              name = "m4v";
              text = "";
            }
            {
              name = "m4a";
              text = "";
            }
            {
              name = "tf";
              text = "";
            }
            {
              name = "gv";
              text = "󱁉";
            }
            {
              name = "lock";
              text = "";
            }
            {
              name = "krz";
              text = "";
            }
            {
              name = "kpp";
              text = "";
            }
            {
              name = "ko";
              text = "";
            }
            {
              name = "kicad_sym";
              text = "";
            }
            {
              name = "psm1";
              text = "󰨊";
            }
            {
              name = "pyx";
              text = "";
            }
            {
              name = "json5";
              text = "";
            }
            {
              name = "json";
              text = "";
            }
            {
              name = "bzl";
              text = "";
            }
            {
              name = "ifb";
              text = "";
            }
            {
              name = "image";
              text = "";
            }
            {
              name = "jpg";
              text = "";
            }
            {
              name = "jpeg";
              text = "";
            }
            {
              name = "java";
              text = "";
            }
            {
              name = "wv";
              text = "";
            }
            {
              name = "ini";
              text = "";
            }
            {
              name = "cast";
              text = "";
            }
            {
              name = "cp";
              text = "";
            }
            {
              name = "fctl";
              text = "";
            }
            {
              name = "ifc";
              text = "󰻫";
            }
            {
              name = "sldasm";
              text = "󰻫";
            }
            {
              name = "html";
              text = "";
            }
            {
              name = "typoscript";
              text = "";
            }
            {
              name = "🔥";
              text = "";
            }
            {
              name = "htm";
              text = "";
            }
            {
              name = "ste";
              text = "󰻫";
            }
            {
              name = "spec.js";
              text = "";
            }
            {
              name = "gresource";
              text = "";
            }
            {
              name = "ebook";
              text = "";
            }
            {
              name = "gradle";
              text = "";
            }
            {
              name = "gd";
              text = "";
            }
            {
              name = "fish";
              text = "";
            }
            {
              name = "igs";
              text = "󰻫";
            }
            {
              name = "fbx";
              text = "󰆧";
            }
            {
              name = "env";
              text = "";
            }
            {
              name = "srt";
              text = "󰨖";
            }
            {
              name = "dot";
              text = "󱁉";
            }
            {
              name = "doc";
              text = "󰈬";
            }
            {
              name = "d.ts";
              text = "";
            }
            {
              name = "applescript";
              text = "";
            }
            {
              name = "cxx";
              text = "";
            }
            {
              name = "img";
              text = "";
            }
            {
              name = "cljs";
              text = "";
            }
            {
              name = "cobol";
              text = "⚙";
            }
            {
              name = "cob";
              text = "⚙";
            }
            {
              name = "cmake";
              text = "";
            }
            {
              name = "webp";
              text = "";
            }
          ];
        };
      };
    };
  };
}

{ config, inputs, pkgs, ... }:
{

  xdg.configFile = {
    "yazi/init.lua" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/yazi/config/init.lua";
    };
    "yazi/plugins/" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/yazi/config/plugins/";
    };
    "yazi/Catppuccin-mocha.tmTheme" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/yazi/config/Catppuccin-mocha.tmTheme";
    };
  };

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    package = inputs.yazi.packages.${pkgs.system}.default;
    settings = {
      log = {
        enabled = false;
      };

      manager = {
        show_hidden = true;
        sort_by = "alphabetical";
        sort_dir_first = true;
        sort_translit = false;
        show_symlink = true;
        linemode = "mtime";
        mouse_events = [
          "click"
          "scroll"
        ];
        ratio = [1 5 2];
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
      manager.keymap = [
        # Go to
        { run = "cd ~"; on = ["g" "c" "d"]; desc = "Go to home directory";}
        { run = "cd ~/.config"; on = ["g" "c" "c"]; desc = "";}
        { run = "cd ~/.dotfiles"; on = ["g" "d" "d"]; desc = "Go to .dotfiles";}
        { run = "cd ~/.fonts"; on = ["g" "f" "f"]; desc = "Go to .fonts";}
        { run = "cd ~/.trash"; on = ["g" "t" "r"]; desc = "Go to .trash";}
        { run = "cd ~/.wallpapers"; on = ["g" "w"]; desc = "Go to .wallpapers";}
        { run = "cd ~/Downloads"; on = [ "g" "D" ]; desc = "Go to Downloads"; }
        { run = "cd ~/Documents"; on = ["g" "d" "c"]; desc = "Go to Documents";}
        { run = "cd ~/Pictures"; on = ["g" "p" "p"]; desc = "Go to Pictures";}
        { run = "cd ~/Projects"; on = ["g" "P"]; desc = "Go to Projects";}
        { run = "cd ~/Pictures/Screenshots"; on = ["g" "p" "s"]; desc = "Go to Screenshots";}
        { run = "cd ~/Videos"; on = ["g" "v"]; desc = "Go to Videos";}

        # Tabs
        { run = "tab_create --current"; on = "<C-t>"; desc = "Create new tab";}
        { run = "tab_switch 0"; on = "1"; desc = "Switch to the first tab";}
        { run = "tab_switch 1"; on = "2"; desc = "Switch to the second tab";}
        { run = "tab_switch 2"; on = "3"; desc = "Switch to the third tab";}
        { run = "tab_switch 3"; on = "4"; desc = "Switch to the fourth tab";}
        { run = "tab_switch 4"; on = "5"; desc = "Switch to the fifth tab";}
        { run = "tab_switch 5"; on = "6"; desc = "Switch to the sixth tab";}
        { run = "tab_switch 6"; on = "7"; desc = "Switch to the seventh tab";}
        { run = "tab_switch 7"; on = "8"; desc = "Switch to the eighth tab";}
        { run = "tab_switch 8"; on = "9"; desc = "Switch to the ninth tab";}
        { run = "tab_switch -1 --relative"; on = "["; desc = "Switch to the previous tab";}
        { run = "tab_switch 1 --relative"; on = "]";  desc = "Switch to the next tab";}
        { run = "tab_swap -1"; on = "{"; desc = "Swap current tab with previous tab";}
        { run = "tab_swap 1"; on = "}"; desc = "Swap current tab with next tab";}

        # Tasks
        { run = "tasks_show"; on = ["t" "s"]; desc = "Show task manager";}

        # Help
        { run = "help"; on = "<F1>"; desc = "Open help";}

        # Misc
        { run = "quit"; on = "q"; desc = "Exit explorer";}
        { run = "hidden toggle"; on = "."; desc = "Toggle visibility of hidden files";}

        # Shell
        { run = "shell --interactive"; on = ";"; desc = "Run a shell command";}
        { run = "shell --block --interactive"; on = ":"; desc = "Run a shell command (block until finishes)";}
        
        # Search | Find | Filter
        { run = "search fd"; on = ["f" "d"]; desc = "Search files by name using fd";}
        { run = "search rg"; on = ["f" "g"]; desc = "Search files by content using ripgrep";}
        { run = "plugin fzf"; on = ["f" "z"]; desc = "Jump to a directory or reveal a file using fzf";}
        { run = "find --smart"; on = "/"; desc = "Find next file";}
        { run = "find --previous --smart"; on = "?"; desc = "Find previous file";}
        { run = "find_arrow"; on = ["f" "n"]; desc = "Go to the next found";}
        { run = "find_arrow --previous"; on = ["f" "N"]; desc = "Go to the previous found";}
        { run = "filter --smart"; on = ["f" "f"]; desc = "Filter files";}

        # Seek
        { run = "seek -5"; on = "K"; desc = "Seek up 5 units in preview";}
        { run = "seek 5"; on = "J"; desc = "Seek down 5 units in preview";}

        # Selection
        { run = "visual_mode"; on = "v"; desc = "Enter visual mode";}
        { run = "visual_mode --unset"; on = "V"; desc = "Enter visual mode";}
        { run = "select_all --state=true"; on = "<C-a>"; desc = "Select all";}
        { run = "select_all --state=none"; on = "<C-r>"; desc = "Unselect all";}

        # Navigation
        { run = "leave"; on = "h"; desc = "Move right";}
        { run = "enter"; on = "l"; desc = "Move left";}
        { run = "arrow -1"; on = "k"; desc = "Move up";}
        { run = "arrow 1"; on = "j"; desc = "Move down";}
        { run = "leave"; on = "<Left>"; desc = "Move left";}
        { run = "enter"; on = "<Right>"; desc = "Move right";}
        { run = "arrow -1"; on = "<Up>"; desc = "Move up";}
        { run = "arrow 1"; on = "<Down>"; desc = "Move down";}
        { run = "arrow -50%"; on = "<C-k>"; desc = "Move down by half";}
        { run = "arrow 50%"; on = "<C-j>"; desc = "Move up by half";}
        { run = "arrow -99999999"; on = ["g" "g"]; desc = "Move to top";}
        { run = "arrow 99999999"; on = ["g" "G"]; desc = "Move to bottom";}

        # Copy | Cut | Delete | Create | Rename | Filter | Open
        { run = "open"; on = ["e" "e"]; desc = "Open selected file(s)";}
        { run = "open --interactive"; on = ["e" "E"]; desc = "Open selected file(s) interactively";}
        { run = "yank"; on = ["y" "y"]; desc = "Copy file(s)";}
        { run = "yank --cut"; on = [ "d" "d"]; desc = "Cut file(s)";}
        { run = "copy path"; on = ["c" "c"]; desc = "Copy the file path";}
        { run = "copy dirname"; on = ["c" "p"]; desc = "Copy the file directory path";}
        { run = "copy filename"; on = ["c" "f"]; desc = "Copy the filename";}
        { run = "copy name_without_ext"; on = ["c" "n"]; desc = "Copy the filename without the extension";}
        { run = "paste"; on = [ "p" "p" ]; desc = "Paste file(s)";}
        { run = "paste --force"; on = ["p" "P"]; desc = "Overwrite paste file(s)";}
        { run = "remove"; on = ["d" "t"]; desc = "Trash selected file(s)";}
        { run = "remove --w permanently"; on = ["d" "D"]; desc = "Delete selected file(s)";}
        { run = "create"; on = ["m" "k"]; desc = "Create a file (ends with / for directories)";}
        { run = "rename --cursor=before_ext"; on = ["r" "r"]; desc = "Rename selected file(s)";}

        # Sorting
        { run = [ "sort modified --reverse=no" "linemode mtime" ]; on = [ ";" "m" ]; desc = "Sort by modified time";}
        { run = [ "sort modified --reverse" "linemode mtime" ]; on = [ ";" "M" ]; desc = "Sort by modified time (reverse)"; }
        { run = [ "sort created --reverse=no" "linemode ctime" ]; on = [ ";" "c" ]; desc = "Sort by created time"; }
        { run = [ "sort created --reverse" "linemode ctime" ]; on = [ ";" "C" ]; desc = "Sort by created time (reverse)"; }
        { run = "sort extension --reverse=no"; on = [ ";" "e" ]; desc = "Sort by extension"; }
        { run = "sort extension --reverse"; on = [ ";" "E" ]; desc = "Sort by extension (reverse)"; }
        { run = "sort alphabetical --reverse=no"; on = [ ";" "a" ]; desc = "Sort alphabetically"; }
        { run = "sort alphabetical --reverse"; on = [ ";" "A" ]; desc = "Sort alphabetically (reverse)"; }
        { run = "sort natural --reverse=no"; on = [ ";" "n" ]; desc = "Sort naturally"; }
        { run = "sort natural --reverse"; on = [ ";" "N" ]; desc = "Sort naturally (reverse)"; }
        { run = [ "sort size --reverse=no" "linemode size" ]; on = [ ";" "s" ]; desc = "Sort by size"; }
        { run = [ "sort size --reverse" "linemode size" ]; on = [ ";" "S" ]; desc = "Sort by size (reverse)"; }
        { run = "sort random --reverse=no"; on = [ ";" "r" ]; desc = "Sort randomly"; }
      ];
    };

    theme = {
      manager = {
        cwd = { fg = "#94e2d5"; };

        # Hovered
        hovered = { fg = "#1e1e2e"; bg = "#89b4fa"; };
        preview_hovered = { underline = true; };
        # Find
        find_keyword  = { fg = "#f9e2af"; italic = true; };
        find_position = { fg = "#f5c2e7"; bg = "reset"; italic = true; };

        # Marker
        marker_copied   = { fg = "#a6e3a1"; bg = "#a6e3a1"; };
        marker_cut      = { fg = "#f38ba8"; bg = "#f38ba8"; };
        marker_selected = { fg = "#89b4fa"; bg = "#89b4fa"; };

        # Tab
        tab_active   = { fg = "#1e1e2e"; bg = "#cdd6f4"; };
        tab_inactive = { fg = "#cdd6f4"; bg = "#45475a"; };
        tab_width    = 1;

        # Count
        count_copied   = { fg = "#1e1e2e"; bg = "#a6e3a1"; };
        count_cut      = { fg = "#1e1e2e"; bg = "#f38ba8"; };
        count_selected = { fg = "#1e1e2e"; bg = "#89b4fa"; };

        # Border
        border_symbol = "│";
        border_style  = { fg = "#7f849c"; };

        # Highlighting
        syntect_theme = "~/.config/yazi/Catppuccin-mocha.tmTheme";
      };

      status = {
        separator_open  = "";
        separator_close = "";
        separator_style = { fg = "#45475a"; bg = "#45475a"; };

        # Mode
        mode_normal = { fg = "#1e1e2e"; bg = "#89b4fa"; bold = true; };
        mode_select = { fg = "#1e1e2e"; bg = "#a6e3a1"; bold = true; };
        mode_unset  = { fg = "#1e1e2e"; bg = "#f2cdcd"; bold = true; };

        # Progress
        progress_label  = { fg = "#ffffff"; bold = true; };
        progress_normal = { fg = "#89b4fa"; bg = "#45475a"; };
        progress_error  = { fg = "#f38ba8"; bg = "#45475a"; };

        # Permissions
        permissions_t = { fg = "#89b4fa"; };
        permissions_r = { fg = "#f9e2af"; };
        permissions_w = { fg = "#f38ba8"; };
        permissions_x = { fg = "#a6e3a1"; };
        permissions_s = { fg = "#7f849c"; };
      };

      input = {
        border   = { fg = "#89b4fa"; };
        title    = {};
        value    = {};
        selected = { reversed = true; };
      };

      select = {
        border   = { fg = "#89b4fa"; };
        active   = { fg = "#f5c2e7"; };
        inactive = {};
      };

      tasks = {
        border  = { fg = "#89b4fa"; };
        title   = {};
        hovered = { underline = true; };
      };

      which = {
        mask            = { bg = "#313244"; };
        cand            = { fg = "#94e2d5"; };
        rest            = { fg = "#9399b2"; };
        desc            = { fg = "#f5c2e7"; };
        separator       = "  ";
        separator_style = { fg = "#585b70"; };
      };

      help = {
        on      = { fg = "#f5c2e7"; };
        exec    = { fg = "#94e2d5"; };
        desc    = { fg = "#9399b2"; };
        hovered = { bg = "#585b70"; bold = true; };
        footer  = { fg = "#45475a"; bg = "#cdd6f4"; };
      };
      filetype = {
        rules = [
          # Media
          { mime = "image/*"; fg = "#94e2d5"; }
          { mime = "{audio,video}/*"; fg = "#f9e2af"; }

          # Archives
          { mime = "application/{,g}zip"; fg = "#f5c2e7"; }
          { mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}"; fg = "#f5c2e7"; }

          # Fallback
          { name = "*"; fg = "#cdd6f4"; }
          { name = "*/"; fg = "#89b4fa"; }
        ];
      };

      icon = {
        files = [
          { name = "gulpfile.js"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = ".babelrc"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "copying.lesser"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = ".npmrc"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "docker-compose.yml"; text = "󰡨"; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "svelte.config.js"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "copying"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "prettier.config.ts"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "gruntfile.babel.js"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = ".SRCINFO"; text = "󰣇"; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = ".xinitrc"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "docker-compose.yaml"; text = "󰡨"; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "nuxt.config.ts"; text = "󱄆"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "build"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = ".editorconfig"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "nuxt.config.mjs"; text = "󱄆"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = ".gitlab-ci.yml"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "PKGBUILD"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = ".bash_profile"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = ".bashrc"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "compose.yml"; text = "󰡨"; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "eslint.config.cjs"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "go.mod"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = ".mailmap"; text = "󰊢"; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "gtkrc"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "go.work"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "justfile"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "kritadisplayrc"; text = ""; fg_dark = "#cba6f7"; fg_light = "#cba6f7"; }
          { name = "commitlint.config.js"; text = "󰜘"; fg_dark = "#94e2d5"; fg_light = "#94e2d5"; }
          { name = ".env"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "PrusaSlicerGcodeViewer.ini"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "r"; text = "󰟔"; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "license"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = ".gitignore"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "tailwind.config.js"; text = "󱏿"; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = ".prettierrc.yml"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = ".zprofile"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = ".zshenv"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "xmonad.hs"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = ".eslintignore"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "tsconfig.json"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = ".prettierrc.json5"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = ".ds_store"; text = ""; fg_dark = "#45475a"; fg_light = "#45475a"; }
          { name = "gulpfile.coffee"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "R"; text = "󰟔"; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = ".zshrc"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = ".prettierrc.toml"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = ".gvimrc"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = ".xsession"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = ".justfile"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = ".gitconfig"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "gradle-wrapper.properties"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "ionic.config.json"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "cantorrc"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = ".gleam"; text = ""; fg_dark = "#f5c2e7"; fg_light = "#f5c2e7"; }
          { name = "package-lock.json"; text = ""; fg_dark = "#313244"; fg_light = "#313244"; }
          { name = "package.json"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "hyprland.conf"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "gulpfile.babel.js"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = ".nvmrc"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = ".prettierignore"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "ext_typoscript_setup.txt"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "QtProject.conf"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "avif"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "mix.lock"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "build.gradle"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "gemfile$"; text = ""; fg_dark = "#313244"; fg_light = "#313244"; }
          { name = ".vimrc"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "i18n.config.ts"; text = "󰗊"; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "gulpfile.ts"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "build.zig.zon"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "checkhealth"; text = "󰓙"; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "xmobarrc"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "_vimrc"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = ".luaurc"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "kdenlive-layoutsrc"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "gradlew"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "xsettingsd.conf"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "vlcrc"; text = "󰕼"; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "xorg.conf"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "xmobarrc.hs"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "workspace"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = ".gitattributes"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "favicon.ico"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "go.sum"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "pom.xml"; text = ""; fg_dark = "#313244"; fg_light = "#313244"; }
          { name = "webpack"; text = "󰜫"; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "vagrantfile$"; text = ""; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "unlicense"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "tmux.conf.local"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "settings.gradle"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = ".dockerignore"; text = "󰡨"; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "sym-lib-table"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "_gvimrc"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "kdenliverc"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "kdeglobals"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = ".prettierrc.yaml"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "rmd"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "tailwind.config.mjs"; text = "󱏿"; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "sxhkdrc"; text = ""; fg_dark = "#313244"; fg_light = "#313244"; }
          { name = "robots.txt"; text = "󰚩"; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "tailwind.config.ts"; text = "󱏿"; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "prettier.config.mjs"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "mpv.conf"; text = ""; fg_dark = "#1e1e2e"; fg_light = "#1e1e2e"; }
          { name = "py.typed"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "PrusaSlicer.ini"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "procfile"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "rakefile"; text = ""; fg_dark = "#313244"; fg_light = "#313244"; }
          { name = "kritarc"; text = ""; fg_dark = "#cba6f7"; fg_light = "#cba6f7"; }
          { name = ".Xresources"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "prettier.config.js"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "commitlint.config.ts"; text = "󰜘"; fg_dark = "#94e2d5"; fg_light = "#94e2d5"; }
          { name = "weston.ini"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "eslint.config.js"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "cmakelists.txt"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = ".git-blame-ignore-revs"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "config"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "nuxt.config.cjs"; text = "󱄆"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "node_modules"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "makefile"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "lxqt.conf"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "i18n.config.js"; text = "󰗊"; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "FreeCAD.conf"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "prettier.config.cjs"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "tmux.conf"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "kalgebrarc"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "i3status.conf"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = ".settings.json"; text = ""; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "containerfile"; text = "󰡨"; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "i3blocks.conf"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "lxde-rc.xml"; text = ""; fg_dark = "#9399b2"; fg_light = "#9399b2"; }
          { name = "gradle.properties"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "hypridle.conf"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "gruntfile.ts"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "gruntfile.js"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "dockerfile"; text = "󰡨"; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "groovy"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "hyprlock.conf"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = ".prettierrc"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "gnumakefile"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "commit_editmsg"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "fp-lib-table"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "fp-info-cache"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "eslint.config.ts"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "nuxt.config.js"; text = "󱄆"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "platformio.ini"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = ".nuxtrc"; text = "󱄆"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "gruntfile.coffee"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "eslint.config.mjs"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "compose.yaml"; text = "󰡨"; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "bspwmrc"; text = ""; fg_dark = "#313244"; fg_light = "#313244"; }
          { name = "brewfile"; text = ""; fg_dark = "#313244"; fg_light = "#313244"; }
          { name = ".eslintrc"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = ".gtkrc-2.0"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = ".Xauthority"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = ".prettierrc.json"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = ".npmignore"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = ".gitmodules"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
        ];

        exts = [
          { name = "rake"; text = ""; fg_dark = "#313244"; fg_light = "#313244"; }
          { name = "skp"; text = "󰻫"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "eln"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "razor"; text = "󱦘"; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "vue"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "sln"; text = ""; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "el"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "blp"; text = "󰺾"; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "jl"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "mdx"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "jsx"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "ml"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "less"; text = ""; fg_dark = "#45475a"; fg_light = "#45475a"; }
          { name = "pot"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "pl"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "mli"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "gif"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "aif"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "cxxm"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "fcbak"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "aac"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "query"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "android"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "m3u8"; text = "󰲹"; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "leex"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "liquid"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "cue"; text = "󰲹"; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "fcmacro"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "log"; text = "󰌱"; fg_dark = "#cdd6f4"; fg_light = "#cdd6f4"; }
          { name = "pm"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "brep"; text = "󰻫"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "blend"; text = "󰂫"; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "md5"; text = "󰕥"; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "sql"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "xcplayground"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "erb"; text = ""; fg_dark = "#313244"; fg_light = "#313244"; }
          { name = "t"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "cache"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "r"; text = "󰟔"; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "x"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "import"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "m"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "lrc"; text = "󰨖"; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "o"; text = ""; fg_dark = "#45475a"; fg_light = "#45475a"; }
          { name = "d"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "c"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "h"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "rss"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "hbs"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "godot"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "eot"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "awk"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "fsx"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "a"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "pyi"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "asc"; text = "󰦝"; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "ass"; text = "󰨖"; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "css"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "psb"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "csproj"; text = "󰪮"; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "csv"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "gcode"; text = "󰐫"; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "ics"; text = ""; fg_dark = "#313244"; fg_light = "#313244"; }
          { name = "mk"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "bz"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "fctb"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "gz"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "wasm"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "glb"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "elc"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "flf"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "elf"; text = ""; fg_dark = "#45475a"; fg_light = "#45475a"; }
          { name = "dropbox"; text = ""; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "tres"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "apk"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "ape"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "slvs"; text = "󰻫"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "apl"; text = "⍝"; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "cs"; text = "󰌛"; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "azcli"; text = ""; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "pp"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "flc"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "gemspec"; text = ""; fg_dark = "#313244"; fg_light = "#313244"; }
          { name = "pls"; text = "󰲹"; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "cfg"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "fcscript"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "gnumakefile"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "zst"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "pxi"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "woff2"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "kicad_pcb"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "zsh"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "kicad_wks"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "info"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "cppm"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "svg"; text = "󰜡"; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "flac"; text = ""; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "cuh"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "bin"; text = ""; fg_dark = "#45475a"; fg_light = "#45475a"; }
          { name = "zig"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "yml"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "yaml"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "fsscript"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "xz"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "diff"; text = ""; fg_dark = "#45475a"; fg_light = "#45475a"; }
          { name = "mojo"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "cshtml"; text = "󱦗"; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "bak"; text = "󰁯"; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "nfo"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "bat"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "cpy"; text = "⚙"; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "gql"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "c++"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "lff"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "obj"; text = "󰆧"; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "sha512"; text = "󰕥"; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "scm"; text = "󰘧"; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "aiff"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "sig"; text = "λ"; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "webm"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "zip"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "wrz"; text = "󰆧"; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "jwmrc"; text = ""; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "xml"; text = "󰗀"; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "cbl"; text = "⚙"; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "rmd"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "xaml"; text = "󰙳"; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "xm"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "wvc"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "drl"; text = ""; fg_dark = "#eba0ac"; fg_light = "#eba0ac"; }
          { name = "erl"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "3gp"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "ccm"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "ino"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "kbx"; text = "󰯄"; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "test.js"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "wrl"; text = "󰆧"; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "pcm"; text = ""; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "woff"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "scala"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "webpack"; text = "󰜫"; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "hrl"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "kra"; text = ""; fg_dark = "#cba6f7"; fg_light = "#cba6f7"; }
          { name = "kicad_pro"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "bazel"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "toml"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "iges"; text = "󰻫"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "crdownload"; text = ""; fg_dark = "#94e2d5"; fg_light = "#94e2d5"; }
          { name = "so"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "strings"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "xls"; text = "󰈛"; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "wav"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "vsix"; text = ""; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "kicad_prl"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "mov"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "bash"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "sqlite3"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "vsh"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "vim"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "lck"; text = ""; fg_dark = "#bac2de"; fg_light = "#bac2de"; }
          { name = "go"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "pyo"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "vhdl"; text = "󰍛"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "vhd"; text = "󰍛"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "rar"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "magnet"; text = ""; fg_dark = "#45475a"; fg_light = "#45475a"; }
          { name = "vala"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "coffee"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "kdbx"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "po"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "v"; text = "󰍛"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "prisma"; text = ""; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "f90"; text = "󱈚"; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "txt"; text = "󰈙"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "mo"; text = "∞"; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "mp4"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "cljc"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "heex"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "exs"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "clj"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "luau"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "fcparam"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "markdown"; text = ""; fg_dark = "#cdd6f4"; fg_light = "#cdd6f4"; }
          { name = "dxf"; text = "󰻫"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "luac"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "desktop"; text = ""; fg_dark = "#45475a"; fg_light = "#45475a"; }
          { name = "docx"; text = "󰈬"; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "cljd"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "txz"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "bicepparam"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "kt"; text = ""; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "fcstd"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "md"; text = ""; fg_dark = "#cdd6f4"; fg_light = "#cdd6f4"; }
          { name = "edn"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "sub"; text = "󰨖"; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "ttf"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "tsx"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "hurl"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "dll"; text = ""; fg_dark = "#11111b"; fg_light = "#11111b"; }
          { name = "lhs"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "tsconfig"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "msf"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "ts"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "rproj"; text = "󰗆"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "org"; text = ""; fg_dark = "#94e2d5"; fg_light = "#94e2d5"; }
          { name = "signature"; text = "λ"; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "elm"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "pyc"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "tmux"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "tgz"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "nu"; text = ">"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "tfvars"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "lua"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "astro"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "lib"; text = ""; fg_dark = "#11111b"; fg_light = "#11111b"; }
          { name = "tex"; text = ""; fg_dark = "#45475a"; fg_light = "#45475a"; }
          { name = "ogg"; text = ""; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "stp"; text = "󰻫"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "sublime"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "test.tsx"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "nswag"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "test.ts"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "test.jsx"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "dwg"; text = "󰻫"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "bib"; text = "󱉟"; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "sass"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "templ"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "tcl"; text = "󰛓"; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "pck"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "swift"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "makefile"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "xcstrings"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "slim"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "iso"; text = ""; fg_dark = "#f2cdcd"; fg_light = "#f2cdcd"; }
          { name = "fsi"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "dart"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "nix"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "svelte"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "sv"; text = "󰍛"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "bz2"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "sha256"; text = "󰕥"; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "twig"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "material"; text = "󰔉"; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "ppt"; text = "󰈧"; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "pyd"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "step"; text = "󰻫"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "hx"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "webmanifest"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "kicad_sch"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "cjs"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "stl"; text = "󰆧"; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "ejs"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "ssa"; text = "󰨖"; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "license"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "jsonc"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "download"; text = ""; fg_dark = "#94e2d5"; fg_light = "#94e2d5"; }
          { name = "ige"; text = "󰻫"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "sqlite"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "psd1"; text = "󰨊"; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "dump"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "resi"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "spec.ts"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "fnl"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "cu"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "scss"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "config.ru"; text = ""; fg_dark = "#313244"; fg_light = "#313244"; }
          { name = "psd"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "db"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "epub"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "haml"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "sol"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "sml"; text = "λ"; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "svh"; text = "󰍛"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "sldprt"; text = "󰻫"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "ico"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "xlsx"; text = "󰈛"; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "rs"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "dconf"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "bz3"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "fdmdownload"; text = ""; fg_dark = "#94e2d5"; fg_light = "#94e2d5"; }
          { name = "fs"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "patch"; text = ""; fg_dark = "#45475a"; fg_light = "#45475a"; }
          { name = "hs"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "xcf"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "js"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "pyw"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "sha384"; text = "󰕥"; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "fcmat"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "csh"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "suo"; text = ""; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "sha224"; text = "󰕥"; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "sha1"; text = "󰕥"; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "cr"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "huff"; text = "󰡘"; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "sh"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "sc"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "ksh"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "cc"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "wma"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "mp3"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "conf"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "3mf"; text = "󰆧"; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "sbt"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "kicad_mod"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "terminal"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "rlib"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "pdf"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "mts"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "kdenlive"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "kts"; text = ""; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "spec.tsx"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "res"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "hxx"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "rb"; text = ""; fg_dark = "#313244"; fg_light = "#313244"; }
          { name = "vh"; text = "󰍛"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "ixx"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "cson"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "cts"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "7z"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "ex"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "cpp"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "qss"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "app"; text = ""; fg_dark = "#45475a"; fg_light = "#45475a"; }
          { name = "jxl"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "qrc"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "qml"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "epp"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "otf"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "hh"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "qm"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "pro"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "exe"; text = ""; fg_dark = "#45475a"; fg_light = "#45475a"; }
          { name = "kdenlivetitle"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "kdb"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "mpp"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "Dockerfile"; text = "󰡨"; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "bqn"; text = "⎉"; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "torrent"; text = ""; fg_dark = "#94e2d5"; fg_light = "#94e2d5"; }
          { name = "m3u"; text = "󰲹"; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "py"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "pxd"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "f3d"; text = "󰻫"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "out"; text = ""; fg_dark = "#45475a"; fg_light = "#45475a"; }
          { name = "spec.jsx"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "kicad_dru"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "ps1"; text = "󰨊"; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "ui"; text = ""; fg_dark = "#313244"; fg_light = "#313244"; }
          { name = "styl"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "f#"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "png"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "ply"; text = "󰆧"; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "php"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "eex"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "tbc"; text = "󰛓"; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "part"; text = ""; fg_dark = "#94e2d5"; fg_light = "#94e2d5"; }
          { name = "pub"; text = "󰷖"; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "ipynb"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "opus"; text = ""; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "git"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "bmp"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "blade.php"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "nim"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "xpi"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "mustache"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "tscn"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "scad"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "ai"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "hex"; text = ""; fg_dark = "#6c7086"; fg_light = "#6c7086"; }
          { name = "hpp"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "xul"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "mobi"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "fcstd1"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "ical"; text = ""; fg_dark = "#313244"; fg_light = "#313244"; }
          { name = "icalendar"; text = ""; fg_dark = "#313244"; fg_light = "#313244"; }
          { name = "bicep"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "mm"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "mkv"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "graphql"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "mjs"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "mint"; text = "󰌪"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "m4v"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "m4a"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "tf"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "gv"; text = "󱁉"; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "lock"; text = ""; fg_dark = "#bac2de"; fg_light = "#bac2de"; }
          { name = "krz"; text = ""; fg_dark = "#cba6f7"; fg_light = "#cba6f7"; }
          { name = "kpp"; text = ""; fg_dark = "#cba6f7"; fg_light = "#cba6f7"; }
          { name = "ko"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "kicad_sym"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "psm1"; text = "󰨊"; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "pyx"; text = ""; fg_dark = "#89b4fa"; fg_light = "#89b4fa"; }
          { name = "json5"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "json"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "bzl"; text = ""; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "ifb"; text = ""; fg_dark = "#313244"; fg_light = "#313244"; }
          { name = "image"; text = ""; fg_dark = "#f2cdcd"; fg_light = "#f2cdcd"; }
          { name = "jpg"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "jpeg"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "java"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "wv"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "ini"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "cast"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "cp"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "fctl"; text = ""; fg_dark = "#f38ba8"; fg_light = "#f38ba8"; }
          { name = "ifc"; text = "󰻫"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "sldasm"; text = "󰻫"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "html"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "typoscript"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "🔥"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "htm"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "ste"; text = "󰻫"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "spec.js"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "gresource"; text = ""; fg_dark = "#f5e0dc"; fg_light = "#f5e0dc"; }
          { name = "ebook"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "gradle"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "gd"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "fish"; text = ""; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "igs"; text = "󰻫"; fg_dark = "#a6e3a1"; fg_light = "#a6e3a1"; }
          { name = "fbx"; text = "󰆧"; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "env"; text = ""; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "srt"; text = "󰨖"; fg_dark = "#f9e2af"; fg_light = "#f9e2af"; }
          { name = "dot"; text = "󱁉"; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "doc"; text = "󰈬"; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "d.ts"; text = ""; fg_dark = "#fab387"; fg_light = "#fab387"; }
          { name = "applescript"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "cxx"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "img"; text = ""; fg_dark = "#f2cdcd"; fg_light = "#f2cdcd"; }
          { name = "cljs"; text = ""; fg_dark = "#74c7ec"; fg_light = "#74c7ec"; }
          { name = "cobol"; text = "⚙"; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "cob"; text = "⚙"; fg_dark = "#585b70"; fg_light = "#585b70"; }
          { name = "cmake"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
          { name = "webp"; text = ""; fg_dark = "#7f849c"; fg_light = "#7f849c"; }
        ];
      };
    };
  };
}

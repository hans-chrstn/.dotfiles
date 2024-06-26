{ config, pkgs, ... }:

{

  #xdg.configFile."lf" = {
  #  source = config.lib.file.mkOutOfStoreSymlink "${config.home.homedirectory}/.dotfiles/home/common/programs/lf/config/icons";
  #};

  xdg.configFile."lf/icons" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/lf/config/icons";
  };
  #xdg.configFile."lf/lfrc" = {
  #  enable = false;
  #};

  programs.lf = {
    enable = true;
    extraConfig = ''
      &ctpv -s $id
      &ctpvquit $id
    '';
    settings = {
      shell = "sh";
      hidden = true;
      drawbox = false;
      mouse = true;
      icons = true;
      ignorecase = true;
      previewer = "ctpv";
      cleaner = "ctpvclear";
      ifs = ''\n'';
      scrolloff = "10";
      cursorpreviewfmt = ''\033[7;2m'';
      
    };
    commands = {
      trash = ''
        ''${{
          timestamp=$(date "+%Y-%m-%d_%H-%M-%S")
          mkdir -p ~/.trash/$timestamp
          echo $fx > ~/.trash/$timestamp/.original_path
          mv $fx ~/.trash/$timestamp/
        }}
      '';

      trash-clear = ''
        ''${{
          if [[ -z ~/.trash/* ]]; then
            echo "No files to clear"
            exit 1
          fi
          rm -r ~/.trash/*
        }}
      '';

      trash-restore = ''
        ''${{
          trestore=$(ls -td ~/.trash/*/ | head -n 1)
          opath=$(cat "$trestore/.original_path")
          if [[ -z $trestore/* ]]; then
            echo "No files to restore."
            exit 1
          fi
          trashedfile=$trestore/$(basename "$opath")
          mv $trashedfile $opath
          rm -r $trestore
        }}
      '';

      mkdir = ''
        ''${{
          printf "Directory Name: "
          read ans
          mkdir $ans
        }}
      '';

      mkfile = ''
        ''${{
          printf "File Name: "
          read ans
          $EDITOR $ans
        }}
      '';

      mkscript = ''
        ''${{
          printf "Script Name: "
          read ans
          echo "[ q | Q ] to quit."
          printf "[ BASH | ZSH | PYTHON ]: "
          read sh
          while true; do
            case $sh in
              bash | b | ba | bas | BASH | B | BA | BAS)
                shebang="#!/usr/bin/env bash"
                echo $shebang > "$ans.sh"
                $EDITOR "$ans.sh"
                break
                ;;
              zsh | z | zs | ZSH | Z | ZS)
                shebang="#!/usr/bin/env zsh"
                echo $shebang > "$ans.sh"
                $EDITOR "$ans.sh"
                break
                ;;
              python | p | py | pyt | pyth | pytho | PYTHON | P | PY | PYT | PYTH | PYTHO)
                shebang="#!/usr/bin/env python"
                echo $shebang > "$ans.sh"
                $EDITOR "$ans.sh"
                break
                ;;
              q | Q)
                echo "Exiting.."
                break
                ;;
              *)
                echo "Wrong Filetype"
                echo "[ q | Q ] to quit."
                printf "[ BASH | ZSH | PYTHON ]: "
                read sh
            esac
          done
        }}
      '';

      p7z = ''
        ''${{
          7z a "$fx.7z" $fx
        }}
      '';

      #zip -r $1.zip $1
      zip = ''
        ''${{
          set -f
          mkdir $1
          cp -r $fx $1
          7z a -tzip "$fx.zip" $fx
          rm -rf $1
        }}
      '';

      tar = ''
        ''${{
          set -f
          mkdir $1
          cp -r $fx $1
          tar czf $1.tar.gz $1
          rm -rf $1
        }}
      '';

      extract = ''
        ''${{
          7z x $fx
        }}
      '';

      unrar = ''
        ''${{
          unrar x $fx
        }}
      '';

      chmod = ''
        ''${{
          printf "Mode Bits: "
          read ans
          for file in $fx
          do
            chmod $ans $file
          done
        }}
      '';
    };
    keybindings = {
      # TO REMOVE DEFAULT KEYBINDS
      a = "";
      c = "";
      d = "";
      h = "";
      e = "";
      H = "";
      k = "";
      l = "";
      L = "";
      m = "";
      n = "";
      o = "";
      p = "";
      r = "";
      t = "";
      u = "";
      y = "";

      "." = "set hidden!";
      "`" = "!true";
      ap = "p7z";
      at = "tar";
      ax = "extract";
      au = "unrar";
      az = "zip";
      ch = "chmod";
      cc = "clear";
      dd = "cut";
      dD = "delete";
      dtc = "trash-clear";
      dtt = "trash";
      dtr = "trash-restore";
      ee = ''''$$EDITOR "$f"'';
      eg = ''''$$vscodium "$f"'';
      gD = "cd ~/Downloads";
      gg = "top";
      gG = "bottom";
      gp = "cd ~/Pictures";
      gv = "cd ~/Videos";
      gcc = "cd ~/.config";
      gcd = "cd ~";
      gdc = "cd ~/Documents";
      gdd = "cd ~/.dotfiles";
      gff = "cd ~/.fonts";
      gfl = "cd ~/.floorp";
      gps = "cd ~/Pictures/Screenshots";
      gtr = "cd ~/.trash";
      gws = "cd ~/.wallpapers"; 
      md = "mkdir";
      mf = "mkfile";
      ms = "mkscript";
      pp = "paste";
      rr = "rename";
      rR = "reload";
      shl = "shell";
      tt = "tag-toggle";
      nv = ''''$${pkgs.neovim}/bin/nvim'';
      uu = "unselect";
      xx = ''''$$f'';
      xX = ''!''$f"'';
      yy = "copy";


    };
  };
}

{
  lib,
  config,
  pkgs,
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
      extraPackages = with pkgs; [
        p7zip
        unzip
        gzip
        gnutar
        ripgrep
        fd
        fzf
        zip
        nsxiv
        lazygit
        mediainfo
        mdcat
        duckdb
        hexyl
        unar
        eza
        ffmpeg
        exiftool
      ];

      settings = builtins.fromTOML (builtins.readFile ./config/yazi.toml);
      keymap = builtins.fromTOML (builtins.readFile ./config/keymap.toml);
      theme = builtins.fromTOML (builtins.readFile ./config/theme.toml);

      plugins = let
        yazi-plugins = pkgs.fetchFromGitHub {
          owner = "yazi-rs";
          repo = "plugins";
          rev = "main";
          sha256 = "16gbqcs7wix5f60dlsnyc29ipymk5ms7myn53imzj5qldgkvv33z";
        };
        aminur-plugins = pkgs.fetchFromGitHub {
          owner = "AminurAlam";
          repo = "yazi-plugins";
          rev = "main";
          sha256 = "06zkwpdjpjyigm62gkf39ij2nyi1wrw0w4wkski29lcnpyjsirg7";
        };
      in {
        "compress" = pkgs.fetchFromGitHub {
          owner = "KKV9";
          repo = "compress.yazi";
          rev = "main";
          sha256 = "15qivl0abilp1n3193mk5h69142jpy4yhn2s3xf7y27940n3znya";
        };
        "whoosh" = pkgs.fetchFromGitHub {
          owner = "WhoSowSee";
          repo = "whoosh.yazi";
          rev = "main";
          sha256 = "sha256-is6cjdRzwM32YU9dobg1E6IL1zTf3UlrlnKha4yV2KI=";
        };
        "batch-rename-gui" = pkgs.fetchFromGitHub {
          owner = "pakhromov";
          repo = "batch-rename-gui.yazi";
          rev = "main";
          sha256 = "1cf4jq6fr6xjby4wprcy20prb7js1hb5k5v5whi2cfynilyy46yx";
        };
        "sudo" = pkgs.fetchFromGitHub {
          owner = "TD-Sky";
          repo = "sudo.yazi";
          rev = "main";
          sha256 = "087pncjz5sqf4yy52spvpwhdj05lih2qlsrp7fbh7vr8sryvh1p7";
        };
        "ucp" = pkgs.fetchFromGitHub {
          owner = "simla33";
          repo = "ucp.yazi";
          rev = "main";
          sha256 = "0w9j84rcpgk0lvrc6pkqycp7if6p9a3zsh9fvc3s4lrzryrdzgd0";
        };
        "what-size" = pkgs.fetchFromGitHub {
          owner = "pirafrank";
          repo = "what-size.yazi";
          rev = "main";
          sha256 = "sha256-ZCRxs7KecMgu5tSqQoKCPIELSI2X2SAOeYG6Ct6gTBo=";
        };
        "augment-command" = pkgs.fetchFromGitHub {
          owner = "hankertrix";
          repo = "augment-command.yazi";
          rev = "main";
          sha256 = "0a58afbnb7bwy5km5nydv73zxw52jlza8g71x33d6n9yd3fas7dh";
        };
        "file-extra-metadata" = pkgs.fetchFromGitHub {
          owner = "boydaihungst";
          repo = "file-extra-metadata.yazi";
          rev = "master";
          sha256 = "sha256-CNtIcXQ0rbMdt1lTBeMyz6KZ9fQ3onC8yJ6GZbTuyNk=";
        };
        "lazygit" = pkgs.fetchFromGitHub {
          owner = "Lil-Dank";
          repo = "lazygit.yazi";
          rev = "main";
          sha256 = "1qk0kd2v3f22nh5vh5blgfa5mfv563rmaqhnvc86xl846rgf7yr8";
        };
        "sxiv" = pkgs.fetchFromGitHub {
          owner = "NoponyAsked";
          repo = "sxiv.yazi";
          rev = "master";
          sha256 = "1x5k6620nq0f6bwzzw9f4kni5brzcv8swa7gj4v5dvz6bmps1yy7";
        };
        "eza-preview" = pkgs.fetchFromGitHub {
          owner = "ahkohd";
          repo = "eza-preview.yazi";
          rev = "main";
          sha256 = "02q4573zavrspjmf4m13sqi4xl1i6cdik7qjx9xv9fwmjil0cazj";
        };
        "mediainfo" = pkgs.fetchFromGitHub {
          owner = "boydaihungst";
          repo = "mediainfo.yazi";
          rev = "master";
          sha256 = "0qqdnabyphiv532qw2hjs33pq43ps5k4qid5dhaqmsv776bglvxk";
        };
        "mdcat" = pkgs.fetchFromGitHub {
          owner = "GrzegorzKozub";
          repo = "mdcat.yazi";
          rev = "main";
          sha256 = "0jj7fd8d0nhcz2n4akr8waplqnffc9k44plhghiik70jj02wbcwn";
        };
        "hexyl" = pkgs.fetchFromGitHub {
          owner = "Reledia";
          repo = "hexyl.yazi";
          rev = "main";
          sha256 = "1rc4jkvycgsbyk1pcl9qf92mrq8qm345z9rxl7lpkjvnm4ndqbwp";
        };
        "duckdb" = pkgs.fetchFromGitHub {
          owner = "wylie102";
          repo = "duckdb.yazi";
          rev = "main";
          sha256 = "19hyhqsdaz9szm0dcgc90qw51910q2wz87d8bkhb67bpspkkh0sx";
        };
        "yatline" = pkgs.fetchFromGitHub {
          owner = "imsi32";
          repo = "yatline.yazi";
          rev = "main";
          sha256 = "0r3iv1a807nx6c3n3y8xqzy16v03kq2vkav227jspcq7yl0x2d0y";
        };

        "smart-filter" = "${yazi-plugins}/smart-filter.yazi";
        "git" = "${yazi-plugins}/git.yazi";
        "mime-ext" = "${yazi-plugins}/mime-ext.yazi";
        "full-border" = "${yazi-plugins}/full-border.yazi";

        "spot" = "${aminur-plugins}/spot.yazi";
        "spot-audio" = "${aminur-plugins}/spot-audio.yazi";
        "spot-video" = "${aminur-plugins}/spot-video.yazi";
        "spot-image" = "${aminur-plugins}/spot-image.yazi";
        "spot-cbz" = "${aminur-plugins}/spot-cbz.yazi";
      };
    };
  };
}

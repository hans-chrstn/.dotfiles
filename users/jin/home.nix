{pkgs, ...}: {
  monitors = {
    center-top = {
      name = "DP-1";
      width = 1920;
      height = 1080;
      refreshRate = 99.650000;
      position = {
        x = 1080;
        y = 0;
      };
      scale = 1.0;
    };

    center = {
      name = "HDMI-A-1";
      width = 1920;
      height = 1080;
      refreshRate = 120.000000;
      position = {
        x = 1080;
        y = 1080;
      };
      scale = 1.0;
    };

    center-left = {
      name = "DP-3";
      width = 1920;
      height = 1080;
      refreshRate = 74.973000;
      transform = 270;
      position = {
        x = 0;
        y = 0;
      };
      scale = 1.0;
    };
  };

  theme = {
    enable = true;
    scheme = "tokyo-night";
  };

  home = {
    username = "jin";
    homeDirectory = "/home/jin";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  dotfiles = {
    programs = {
      btop = {
        enable = true;
        enableCustomSettings = true;
      };
      dconf.enable = true;
      direnv.enable = true;
      discord = {
        enable = true;
        useVesktop = false;
      };
      git = {
        enable = true;
        userName = "hayato-oo";
        userEmail = "xuhiko13@gmail.com";
      };
      kitty.enable = true;
      lazygit.enable = true;
      mpv.enable = true;
      neovim.enable = true;
      neofetch.enable = true;
      nix-index.enable = true;
      nyxt.enable = true;
      obs.enable = true;
      unity.enable = true;
      vscode.enable = true;
      yazi.enable = true;
      zen.enable = true;
      tiny.enable = true;
      shell = {
        enableZsh = false;
        enableNushell = true;
        enableFish = true;
        enableStarship = true;
      };
    };
    desktop.widgets = {
      quickshell.enable = true;
      quickshell.systemd.enable = false;
    };
    gaming.minecraft.enable = true;
    hardware.camera.enable = true;
  };

  programs.brave.enable = true;

  services.awww.enable = true;
  services.easyeffects.enable = true;

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    moonlight-qt
    gamma-launcher
    mo2
    attic-client
    starsector

    p7zip
    unrar
    unzip
    zip

    scrcpy
    wf-recorder
    libnotify
    kdePackages.qtmultimedia
    libcava

    feishin
    flatpak
    ffmpeg
    libreoffice
    tradingview
    thunar

    # AI CLI tools
    antigravity-cli
    claude-code
    aider-chat
  ];

  programs.antigravity-cli = {
    enable = true;
  };

  programs.codex.enable = true;

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "26.11";
}

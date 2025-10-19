{
  modules,
  pkgs,
  ...
}: {
  imports = [
    modules.home-manager.btop
    modules.home-manager.camera
    modules.home-manager.dconf
    modules.home-manager.direnv
    modules.home-manager.gaming
    modules.home-manager.git
    modules.home-manager.kitty
    modules.home-manager.lazygit
    modules.home-manager.minecraft
    modules.home-manager.neofetch
    modules.home-manager.neovim
    modules.home-manager.niri
    modules.home-manager.nix-index
    modules.home-manager.obs
    modules.home-manager.theme
    modules.home-manager.unity
    modules.home-manager.vscode
    modules.home-manager.yazi
    modules.home-manager.zen
    modules.home-manager.zsh
  ];

  # nixpkgs.overlays = [
  # Add overlays your own flake exports (from overlays and pkgs dir):
  # outputs.overlays.additions
  # outputs.overlays.modifications
  #
  # You can also add overlays exported from other flakes:
  # neovim-nightly-overlay.overlays.default
  #
  # Or define it inline, for example:
  # (final: prev: {
  #   hi = final.hello.overrideAttrs (oldAttrs: {
  #     patches = [ ./change-hello-to-hi.patch ];
  #   });
  # })
  # ] ++ (builtins.attrValues outputs.overlays);

  home = {
    username = "jin";
    homeDirectory = "/home/jin";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  mod.programs = {
    btop = {
      enable = true;
      enableCustomTheme = true;
      enableCustomSettings = true;
    };
    camera.enable = true;
    dconf.enable = true;
    direnv.enable = true;
    gaming.enable = true;
    git = {
      enable = true;
      userName = "hayato-oo";
      userEmail = "xuhiko13@gmail.com";
      enableGh = false;
    };
    kitty.enable = true;
    lazygit.enable = true;
    minecraft.enable = true;
    neofetch.enable = true;
    neovim.enable = true;
    niri.enable = true;
    nix-index.enable = true;
    obs.enable = true;
    theme.enable = true;
    unity.enable = true;
    vscode.enable = true;
    yazi.enable = true;
    zen.enable = true;
    zsh.enable = true;
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    bebasneue
    apple-fonts
  ];

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}

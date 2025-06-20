{ pkgs, inputs, outputs, ... }:

{
  imports = [
    ./programs.nix
    ./overlays.nix
    ../../common/toru.nix
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  mod = {
    lazygit.enable = true;
    direnv.enable = true;
    git = {
      userName = "hayato-oo";
      userEmail = "xuhiko13@gmail.com";
    };
  };

  home = {
    username = "toru";
    homeDirectory = "/home/toru";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";
  home.stateVersion = "24.11";
}

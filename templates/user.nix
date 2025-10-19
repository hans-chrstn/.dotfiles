{...}: {
  imports = [
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
    username = "NEW_MACHINE_NAME";
    homeDirectory = "/home/NEW_MACHINE_NAME";
    sessionVariables = {
      # EDITOR = "nvim";
    };
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}

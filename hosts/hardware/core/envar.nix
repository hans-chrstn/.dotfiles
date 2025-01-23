{ pkgs, ... }:
{

  environment = {
    localBinInPath = true;
    sessionVariables = {
      LIBVIRTD_ARGS="";
      NIXOS_CONFIG_DIR = "\${HOME}/.dotfiles/";
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_DATA_HOME = "\${HOME}/.local/share";
      NIXPKGS_ALLOW_INSECURE = "1";
      NIXPKGS_ALLOW_UNFREE = "1";
      POLKIT_AUTH_AGENT = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";

      # REMOTE
      RUST_BACKTRACE="1";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}

{ inputs, outputs, ... }:
{

   nixpkgs.overlays = [
    # Add overlays your own flake exports (from overlays and pkgs dir):
    outputs.overlays.additions
    outputs.overlays.modifications

    # You can also add overlays exported from other flakes:
    # neovim-nightly-overlay.overlays.default

    # Or define it inline, for example:
    # (final: prev: {
    #   hi = final.hello.overrideAttrs (oldAttrs: {
    #     patches = [ ./change-hello-to-hi.patch ];
    #   });
    # })
  ]; 
}

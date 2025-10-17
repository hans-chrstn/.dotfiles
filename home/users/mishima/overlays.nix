{ inputs, outputs, ... }:
{

   nixpkgs.overlays = [
    # You can also add overlays exported from other flakes:
    #inputs.neovim-nightly-overlay.overlays.default

    # Or define it inline, for example:
    # (final: prev: {
    #   hi = final.hello.overrideAttrs (oldAttrs: {
    #     patches = [ ./change-hello-to-hi.patch ];
    #   });
    # })
  ] ++ (builtins.attrValues outputs.overlays);
}

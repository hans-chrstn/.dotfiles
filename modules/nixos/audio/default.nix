{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.mod.hardware.audio;
in {
  options.mod.hardware.audio = {
    enable = lib.mkEnableOption "Enable the audio feature";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [wireplumber];
    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber = {
        enable = true;
        extraLv2Packages = [
          pkgs.lsp-plugins
          pkgs.ladspaPlugins
        ];
      };
      extraConfig.pipewire = {
        "92-low-latency" = {
          context.properties = {
            default.clock.rate = 48000;
            default.clock.quantum = 32;
            default.clock.min-quantum = 32;
            default.clock.max-quantum = 32;
          };
        };
        "20-noise-suppression" = {
          context.modules = [
            {
              name = "libpipewire-module-filter-chain";
              args = {
                node.description = "Noise Canceling source";
                media.name = "Noise Canceling source";
                filter.graph = {
                  nodes = [
                    {
                      type = "ladspa";
                      name = "rnnoise";
                      plugin = "ladspa/librnnoise_ladspa";
                      label = "noise_suppressor_stereo";
                      control = "Vad Threshold (%) 50.0";
                    }
                  ];
                };
                capture.props = {
                  node.name = "capture.rnnoise_source";
                  node.passive = "true";
                };
                playback.props = {
                  node.name = "rnnoise_source";
                  media.class = "Audio/Source";
                };
              };
            }
          ];
        };
      };
      extraConfig.pipewire-pulse."92-low-latency" = {
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "32/48000";
              pulse.default.req = "32/48000";
              pulse.max.req = "32/48000";
              pulse.min.quantum = "32/48000";
              pulse.max.quantum = "32/48000";
            };
          }
        ];
        stream.properties = {
          node.latency = "32/48000";
          resample-quality = 1;
        };
      };
    };
  };
}

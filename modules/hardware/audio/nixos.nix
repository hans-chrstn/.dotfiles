{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.dotfiles.hardware.audio;
in {
  options.dotfiles.hardware.audio = {
    enable = lib.mkEnableOption "Enable the audio feature";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [wireplumber qpwgraph];
    services.pulseaudio.enable = false;
    boot.kernelParams = ["usbcore.autosuspend=-1"];
    security.pam.loginLimits = [
      {
        domain = "@audio";
        item = "memlock";
        type = "-";
        value = "unlimited";
      }
      {
        domain = "@audio";
        item = "rtprio";
        type = "-";
        value = "99";
      }
      {
        domain = "@audio";
        item = "nofile";
        type = "soft";
        value = "99999";
      }
      {
        domain = "@audio";
        item = "nofile";
        type = "hard";
        value = "99999";
      }
    ];

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber = {
        enable = true;
        #extraLv2Packages = [
        #  pkgs.lsp-plugins
        #  pkgs.ladspaPlugins
        #];
        #extraConfig = {
        #  "99-disable-suspension" = {
        #    "monitor.alsa.rules" = [
        #      {
        #        matches = [
        #          {
        #            "node.name" = "~alsa_input.*";
        #          }
        #          {
        #            "node.name" = "~alsa_output.*";
        #          }
        #          {
        #            "device.name" = "~alsa_card.*HeadRush*";
        #          }
        #        ];
        #        actions = {
        #          update-props = {
        #            "session.suspend-on-idle" = false;
        #            "session.suspend-timeout-seconds" = 0;
        #            "dma.timeout-ms" = 0;
        #          };
        #        };
        #      }
        #    ];
        #  };
        #};
      };
      # extraConfig.pipewire = {
      #   "92-low-latency" = {
      #     context.properties = {
      #       default.clock.rate = 48000;
      #       default.clock.quantum = 32;
      #       default.clock.min-quantum = 32;
      #       default.clock.max-quantum = 32;
      #     };
      #   };
      #   "20-noise-suppression" = {
      #     context.modules = [
      #       {
      #         name = "libpipewire-module-filter-chain";
      #         args = {
      #           node.description = "Noise Canceling source";
      #           media.name = "Noise Canceling source";
      #           filter.graph = {
      #             nodes = [
      #               {
      #                 type = "ladspa";
      #                 name = "rnnoise";
      #                 plugin = "ladspa/librnnoise_ladspa";
      #                 label = "noise_suppressor_stereo";
      #                 control = "Vad Threshold (%) 50.0";
      #               }
      #             ];
      #           };
      #           capture.props = {
      #             node.name = "capture.rnnoise_source";
      #             node.passive = "true";
      #           };
      #           playback.props = {
      #             node.name = "rnnoise_source";
      #             media.class = "Audio/Source";
      #           };
      #         };
      #       }
      #     ];
      #   };
      # };
      # extraConfig.pipewire-pulse."92-low-latency" = {
      #   context.modules = [
      #     {
      #       name = "libpipewire-module-protocol-pulse";
      #       args = {
      #         pulse.min.req = "32/48000";
      #         pulse.default.req = "32/48000";
      #         pulse.max.req = "32/48000";
      #         pulse.min.quantum = "32/48000";
      #         pulse.max.quantum = "32/48000";
      #       };
      #     }
      #   ];
      #   stream.properties = {
      #     node.latency = "32/48000";
      #     resample-quality = 1;
      #   };
      # };
    };
  };
}

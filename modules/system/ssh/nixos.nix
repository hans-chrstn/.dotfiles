{
  lib,
  config,
  ...
}: let
  cfg = config.dotfiles.services.ssh;
  ipList = lib.concatStringsSep ", " cfg.allowedIps;
in {
  options.dotfiles.services.ssh = {
    enable = lib.mkEnableOption "Enable the ssh feature";
    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Open SSH port (22) to the entire internet";
    };
    passwordAuthentication = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Allow SSH password authentication";
    };
    allowedIps = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Source CIDRs allowed to connect to SSH";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      services.gnome.gcr-ssh-agent.enable = false;
      services.openssh = {
        enable = true;
        allowSFTP = true;
        openFirewall = cfg.openFirewall;
        ports = [22];

        settings = {
          LogLevel = "VERBOSE";
          PermitRootLogin = "no";
          PasswordAuthentication = cfg.passwordAuthentication;
          KbdInteractiveAuthentication = cfg.passwordAuthentication;
          PubkeyAuthentication = true;
          AcceptEnv = ["LANG" "LC_*"];
        };

        extraConfig = ''
          ClientAliveCountMax 0
          ClientAliveInterval 300

          AllowTcpForwarding no
          AllowAgentForwarding no
          MaxAuthTries 3
          MaxSessions 2
          TCPKeepAlive no
        '';
      };

      programs.ssh.startAgent = true;
      services.fail2ban = {
        enable = true;
        jails = {
          sshd.settings = {
            enabled = true;
            port = "ssh";
            filter = "sshd";
            backend = "systemd";
            maxretry = 5;
            bantime = "24h";
          };
        };
      };

      environment.systemPackages = [
        config.services.openssh.package
      ];

      assertions = [
        {
          assertion = !(cfg.openFirewall && cfg.allowedIps != []);
          message = "dotfiles.services.ssh.openFirewall and allowedIps are mutually exclusive";
        }
      ];

      warnings = lib.optional cfg.passwordAuthentication "SSH password authentication is enabled";
    })

    (lib.mkIf (cfg.enable && cfg.allowedIps != []) {
      services.openssh.openFirewall = lib.mkForce false;
      networking.nftables.enable = true;

      networking.firewall.extraInputRules = ''
        ip saddr { ${ipList} } tcp dport 22 accept

      '';
    })
  ];
}

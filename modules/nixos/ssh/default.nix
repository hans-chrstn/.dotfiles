{
  lib,
  config,
  ...
}: let
  cfg = config.mod.services.ssh;
  ipList = lib.concatStringsSep ", " cfg.allowedIps;
in {
  options.mod.services.ssh = {
    enable = lib.mkEnableOption "Enable the ssh feature";
    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Open SSH port (22) to the entire internet";
    };
    allowedIps = lib.mkOption {
      type = lib.types.nullOr (lib.types.listOf lib.types.str);
      default = null;
      description = "List of string that are allowed to access your ssh in your local network";
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
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          PubkeyAuthentication = true;
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
            logpath = "/var/log/auth.log";
            maxretry = 5;
            bantime = "24h";
          };
        };
      };

      environment.systemPackages = [
        config.services.openssh.package
      ];
    })

    (lib.mkIf (cfg.enable && cfg.allowedIps != null) {
      services.openssh.openFirewall = lib.mkForce false;
      networking.nftables.enable = true;

      networking.firewall.extraInputRules = ''
        ip saddr { ${ipList} } tcp dport 22 accept

        ip6 saddr fe80::/10 tcp dport 22 accept
      '';
    })
  ];
}

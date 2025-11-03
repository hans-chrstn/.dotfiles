{
  pkgs,
  config,
  ...
}: {
  systemd.services.wol-servers = {
    description = "Wake up server-1 on boot";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      EnvironmentFile = [config.sops.templates."wol-servers".path];
    };

    script = ''
      if ${pkgs.iputils}/bin/ping -c 1 -W 2 $MAKOTO_IP > /dev/null 2>&1; then
        echo "Server-1 is already online"
        exit 0
      fi

      echo "Sending WoL to server-1 ($MAKOTO_MAC)..."
      ${pkgs.wol}/bin/wol $MAKOTO_MAC || echo "WoL failed"

      TIMEOUT=180
      ELAPSED=0

      until ${pkgs.iputils}/bin/ping -c 1 -W 2 $MAKOTO_IP > /dev/null 2>&1; do
        if [ $ELAPSED -ge $TIMEOUT ]; then
          echo "Server-1 did not respond within $TIMEOUT seconds"
          exit 0
        fi
        if [ $((ELAPSED % 10)) -eq 0 ]; then
          echo "Waiting for server-1... ($ELAPSED/$TIMEOUT seconds)"
        fi
        sleep 2
        ELAPSED=$((ELAPSED + 2))
      done

      echo "Server-1 is online ($ELAPSED seconds)"
    '';
  };
}

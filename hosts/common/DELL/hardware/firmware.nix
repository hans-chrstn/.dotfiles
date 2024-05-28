{ pkgs, ... }:
{
  hardware.firmware = [
    (
      let
        ath10kpkg = builtins.fetchTarball {
          url = "https://github.com/kickTROLL/qca9377/archive/refs/heads/main.zip";
          sha256 = "1v5bc217d9w61fwbgjimf3971dfzwl1gb46l5mzi7pkp9wajf8h6";
        };
      in
      pkgs.runCommandNoCC "qca9377" { } ''
        mkdir -p $out/lib/firmware/ath10k/QCA9377/hw1.0/
        cp ${ath10kpkg}/board-2.bin $out/lib/firmware/ath10k/QCA9377/hw1.0/board-2.bin
        cp ${ath10kpkg}/board.bin $out/lib/firmware/ath10k/QCA9377/hw1.0/board.bin
        cp ${ath10kpkg}/firmware-5.bin $out/lib/firmware/ath10k/QCA9377/hw1.0/firmware-5.bin
        touch $out/lib/firmware/ath10k/QCA9377/hw1.0/firmware-6.bin $out/lib/firmware/ath10k/QCA9377/hw1.0/firmware-sdio-5.bin
      ''
    )
  ];
}

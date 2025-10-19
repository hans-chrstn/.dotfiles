#!/usr/bin/env bash
set -e

MACHINE_NAME=$1
if [ -z "$MACHINE_NAME" ]; then
  echo "Usage: nix run .#new-machine -- <name>"; exit 1;
fi

echo "Setting up new machine: $MACHINE_NAME"
PS3="Select the system type: "
select SYS_TYPE in nixos darwin wsl; do break; done

PS3="Select the architecture: "
select SYS_ARCH in x86_64-linux aarch64-linux x86_64-darwin aarch64-darwin; do break; done

HOST_DIR="hosts/$MACHINE_NAME"
USER_DIR="users/$MACHINE_NAME"

mkdir -p "$HOST_DIR" "$USER_DIR"
echo "Created directories."

sed -e "s/NEW_SYSTEM_TYPE/$SYS_TYPE/" -e "s/NEW_SYSTEM_ARCH/$SYS_ARCH/" templates/system.nix > "$HOST_DIR/system.nix"

sed "s/NEW_MACHINE_NAME/$MACHINE_NAME/g" templates/host.nix > "$HOST_DIR/default.nix"

touch "$HOST_DIR/hardware-configuration.nix"
echo "Created host files."

sed "s/NEW_MACHINE_NAME/$MACHINE_NAME/g" templates/user.nix > "$USER_DIR/home.nix"

echo "Created user files."
echo "Done! Ready to configure '$MACHINE_NAME'."
echo "Note: If this is the first installation, make sure to get a proper hardware-configuration.nix using 'sudo nixos-generate-config --show-hardware-config'"
echo "Paste it here: host/yourusername/hardware-configuration.nix"

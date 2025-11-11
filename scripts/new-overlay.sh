#!/usr/bin/env bash
set -e

OVERLAY_NAME=$1
if [ -z "$OVERLAY_NAME" ]; then
  echo "Usage: nix run .#new-overlay -- <overlay-name>"; exit 1;
fi

OVERLAY_PATH="overlays/$OVERLAY_NAME.nix"

sed "s/NEW_OVERLAY_NAME/$OVERLAY_NAME/g" templates/overlay.nix > "$OVERLAY_PATH"
echo "Created new overlay at '$OVERLAY_PATH'."

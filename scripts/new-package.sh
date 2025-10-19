#!/usr/bin/env bash
set -e

PKG_NAME=$1
if [ -z "$PKG_NAME" ]; then
  echo "Usage: nix run .#new-package -- <package-name>"; exit 1;
fi

PKG_DIR="packages/$PKG_NAME"
PKG_PATH="$PKG_DIR/default.nix"

if [ -d "$PKG_DIR" ]; then
  echo "Error: Package directory '$PKG_DIR' already exists."; exit 1;
fi

mkdir -p "$PKG_DIR"
sed "s/NEW_PACKAGE_NAME/$PKG_NAME/g" templates/package.nix > "$PKG_PATH"
echo "Created new package at '$PKG_PATH'."

#!/usr/bin/env bash
set -e

MODULE_TYPE=$1
MODULE_NAME=$2
if [ -z "$MODULE_TYPE" ] || [ -z "$MODULE_NAME" ]; then
  echo "Usage: nix run .#new-module -- <nixos|home-manager> <module-name>"; exit 1;
fi

MODULE_INDEX="modules/default.nix"
MODULE_DIR="modules/$MODULE_TYPE/$MODULE_NAME"
MODULE_PATH="$MODULE_DIR/default.nix"

if [ -d "$MODULE_DIR" ]; then
  echo "Error: Module directory already exists at $MODULE_DIR."; exit 1;
fi

mkdir -p "$MODULE_DIR"
sed "s/NEW_MODULE_NAME/$MODULE_NAME/g" templates/module.nix > "$MODULE_PATH"
echo "Created new $MODULE_TYPE module at '$MODULE_DIR'."

newLine="    $MODULE_NAME = import ./$MODULE_TYPE/$MODULE_NAME;"
sed -i "/$MODULE_TYPE = {/a\\$newLine" "$MODULE_INDEX"

echo "Registered '$MODULE_NAME' in '$MODULE_INDEX'."

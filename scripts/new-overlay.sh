#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

overlay_name=${1:-}
if [[ -z "$overlay_name" ]]; then
  printf 'Usage: new-overlay <name>\n' >&2
  exit 1
fi

validate_name "$overlay_name"
overlay_path="overlays/$overlay_name.nix"
ensure_absent "$overlay_path"
render templates/overlay.nix "$overlay_path" NEW_OVERLAY_NAME "$overlay_name"
register_entry overlays/registry.nix "\"$overlay_name\""
alejandra "$overlay_path" overlays/registry.nix
printf 'Created %s and registered overlays.%s\n' "$overlay_path" "$overlay_name"

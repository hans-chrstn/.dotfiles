#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

profile_name=${1:-}

if [[ -z "$profile_name" ]]; then
  printf 'Usage: new-profile <name>\n' >&2
  exit 1
fi

validate_name "$profile_name"
ensure_absent "profiles/$profile_name.nix"

render templates/profile.nix "profiles/$profile_name.nix" NEW_PROFILE_NAME "$profile_name"
alejandra "profiles/$profile_name.nix"
printf 'Created profile %s\n' "$profile_name"

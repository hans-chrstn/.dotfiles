#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

username=${1:-}

if [[ -z "$username" ]]; then
  printf 'Usage: new-user <username>\n' >&2
  exit 1
fi

validate_name "$username"
ensure_absent "users/$username"

render templates/user.nix "users/$username/home.nix" NEW_USERNAME "$username"
render templates/user-default.nix "users/$username/default.nix"
alejandra "users/$username"
printf 'Created user %s\n' "$username"

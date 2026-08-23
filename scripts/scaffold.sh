#!/usr/bin/env bash

set -euo pipefail

script_dir=$(dirname "${BASH_SOURCE[0]}")
resource_type=${1:-}

if [[ -z "$resource_type" ]]; then
  printf 'Usage: scaffold <machine|user|module|package|overlay|profile> ...\n' >&2
  exit 1
fi

shift
case "$resource_type" in
  machine) exec "$script_dir/new-machine.sh" "$@" ;;
  user) exec "$script_dir/new-user.sh" "$@" ;;
  module) exec "$script_dir/new-module.sh" "$@" ;;
  package) exec "$script_dir/new-package.sh" "$@" ;;
  overlay) exec "$script_dir/new-overlay.sh" "$@" ;;
  profile) exec "$script_dir/new-profile.sh" "$@" ;;
  *)
    printf 'Unsupported resource type: %s\n' "$resource_type" >&2
    exit 1
    ;;
esac

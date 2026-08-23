#!/usr/bin/env bash

set -euo pipefail

script_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
repo_root=$(git -C "$script_root" rev-parse --show-toplevel)
cd "$repo_root"

validate_name() {
  local name=$1
  if [[ ! "$name" =~ ^[a-z][a-z0-9-]*$ ]]; then
    printf 'Invalid name: %s\n' "$name" >&2
    exit 1
  fi
}

ensure_absent() {
  local path=$1
  if [[ -e "$path" ]]; then
    printf 'Already exists: %s\n' "$path" >&2
    exit 1
  fi
}

register_entry() {
  local registry=$1
  local entry=$2
  local entries
  local output
  entries=$(mktemp)
  output=$(mktemp)
  trap 'rm -f "$entries" "$output"' RETURN
  sed -n '2,$p' "$registry" | sed '$d' >"$entries"
  printf '  %s\n' "$entry" >>"$entries"
  {
    printf '[\n'
    sort -u "$entries"
    printf ']\n'
  } >"$output"
  mv "$output" "$registry"
  rm -f "$entries"
  trap - RETURN
}

unregister_entry() {
  local registry=$1
  local entry=$2
  local output
  output=$(mktemp)
  if ! grep -Fxq "  $entry" "$registry"; then
    printf 'Not registered: %s in %s\n' "$entry" "$registry" >&2
    rm -f "$output"
    exit 1
  fi
  grep -Fvx "  $entry" "$registry" >"$output"
  mv "$output" "$registry"
}

render() {
  local template=$1
  local output=$2
  shift 2
  local temporary
  temporary=$(mktemp)
  cp "$template" "$temporary"
  while (($#)); do
    sed -i "s|$1|$2|g" "$temporary"
    shift 2
  done
  mkdir -p "$(dirname "$output")"
  mv "$temporary" "$output"
}

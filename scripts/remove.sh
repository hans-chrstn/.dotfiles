#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

confirmed=false
if [[ ${1:-} == "--confirm" ]]; then
  confirmed=true
  shift
fi

resource_type=${1:-}
if [[ -z "$resource_type" ]]; then
  printf 'Usage: remove [--confirm] <machine|user|module|package|overlay|profile> ...\n' >&2
  exit 1
fi
shift

target=
registry=
entry=

case "$resource_type" in
  machine)
    name=${1:-}
    validate_name "$name"
    target="hosts/$name"
    registry=hosts/registry.nix
    entry="./$name/metadata.nix"
    ;;
  user)
    name=${1:-}
    validate_name "$name"
    target="users/$name"
    references=$(rg -l -F --glob '*/metadata.nix' -- "username = \"$name\"" hosts || true)
    if [[ -n "$references" ]]; then
      printf 'User %s is still assigned to:\n%s\n' "$name" "$references" >&2
      exit 1
    fi
    ;;
  module)
    module_type=${1:-}
    category=${2:-}
    name=${3:-}
    if [[ "$module_type" != "nixos" && "$module_type" != "home" ]]; then
      printf 'Module type must be nixos or home\n' >&2
      exit 1
    fi
    validate_name "$category"
    validate_name "$name"
    target="modules/$category/$name/$module_type.nix"
    registry="modules/$module_type.nix"
    entry="./$category/$name/$module_type.nix"
    ;;
  package)
    name=${1:-}
    validate_name "$name"
    target="packages/$name"
    registry=packages/registry.nix
    entry="\"$name\""
    references=$(rg -l --pcre2 --glob "!packages/$name/**" --glob '!packages/registry.nix' --glob '!flake.lock' --glob '!.git/**' -- "(?<![A-Za-z0-9_-])$name(?![A-Za-z0-9_-])" . || true)
    if [[ -n "$references" ]]; then
      printf 'Package %s is still referenced by:\n%s\n' "$name" "$references" >&2
      exit 1
    fi
    ;;
  overlay)
    name=${1:-}
    validate_name "$name"
    if [[ -d "overlays/$name" ]]; then
      target="overlays/$name"
    else
      target="overlays/$name.nix"
    fi
    registry=overlays/registry.nix
    entry="\"$name\""
    references=$(rg -l -F --glob '*/metadata.nix' -- "\"$name\"" hosts || true)
    if [[ -n "$references" ]]; then
      printf 'Overlay %s is still selected by:\n%s\n' "$name" "$references" >&2
      exit 1
    fi
    ;;
  profile)
    name=${1:-}
    validate_name "$name"
    target="profiles/$name.nix"
    references=$(rg -l -F --glob '*/metadata.nix' -- "profiles/$name.nix" hosts || true)
    if [[ -n "$references" ]]; then
      printf 'Profile %s is still selected by:\n%s\n' "$name" "$references" >&2
      exit 1
    fi
    ;;
  *)
    printf 'Unsupported resource type: %s\n' "$resource_type" >&2
    exit 1
    ;;
esac

if [[ ! -e "$target" ]]; then
  printf 'Does not exist: %s\n' "$target" >&2
  exit 1
fi

printf 'Resource: %s\nTarget: %s\n' "$resource_type" "$target"
if [[ -n "$registry" ]]; then
  printf 'Registry: %s\nEntry: %s\n' "$registry" "$entry"
fi
if [[ "$resource_type" == "machine" ]]; then
  printf 'SOPS entries and users are not removed automatically.\n'
fi

if [[ "$confirmed" != true ]]; then
  printf 'Dry run only. Repeat with --confirm to remove.\n'
  exit 0
fi

backup_dir=$(mktemp -d)
cp -a "$target" "$backup_dir/target"
if [[ -n "$registry" ]]; then
  cp -a "$registry" "$backup_dir/registry"
fi

restore_removal() {
  rm -rf -- "$target"
  mkdir -p "$(dirname "$target")"
  cp -a "$backup_dir/target" "$target"
  if [[ -n "$registry" ]]; then
    cp -a "$backup_dir/registry" "$registry"
  fi
}

trap 'restore_removal' ERR
trap 'restore_removal; exit 130' INT TERM HUP
trap 'rm -rf "$backup_dir"' EXIT

if [[ -n "$registry" ]]; then
  unregister_entry "$registry" "$entry"
fi

rm -rf -- "$target"
if [[ "$resource_type" == "module" ]]; then
  module_dir=$(dirname "$target")
  rmdir "$module_dir" 2>/dev/null || true
fi

if ! nix flake check --keep-going; then
  restore_removal
  printf 'Validation failed; removal was rolled back.\n' >&2
  exit 1
fi

trap - ERR INT TERM HUP
printf 'Removed %s %s\n' "$resource_type" "$name"

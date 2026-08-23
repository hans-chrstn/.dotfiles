#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

module_type=${1:-}
category=${2:-}
module_name=${3:-}
option_path=${4:-$module_name}

if [[ "$module_type" != "nixos" && "$module_type" != "home" ]] || [[ -z "$category" || -z "$module_name" ]]; then
  printf 'Usage: new-module <nixos|home> <category> <name> [option-path]\n' >&2
  exit 1
fi

validate_name "$category"
validate_name "$module_name"
if [[ ! "$option_path" =~ ^[a-zA-Z][a-zA-Z0-9-]*(\.[a-zA-Z][a-zA-Z0-9-]*)*$ ]]; then
  printf 'Invalid option path: %s\n' "$option_path" >&2
  exit 1
fi

module_path="modules/$category/$module_name/$module_type.nix"
ensure_absent "$module_path"
render templates/module.nix "$module_path" NEW_MODULE_NAME "$module_name" NEW_OPTION_PATH "$option_path"
register_entry "modules/$module_type.nix" "./$category/$module_name/$module_type.nix"
alejandra "$module_path" "modules/$module_type.nix"
printf 'Created %s\n' "$module_path"

#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

package_name=${1:-}
package_type=${2:-application}
if [[ -z "$package_name" ]]; then
  printf 'Usage: new-package <name> [application|derivation]\n' >&2
  exit 1
fi
if [[ "$package_type" != "application" && "$package_type" != "derivation" ]]; then
  printf 'Unsupported package type: %s\n' "$package_type" >&2
  exit 1
fi

validate_name "$package_name"
package_path="packages/$package_name/default.nix"
ensure_absent "packages/$package_name"
render "templates/package-$package_type.nix" "$package_path" NEW_PACKAGE_NAME "$package_name"
register_entry packages/registry.nix "\"$package_name\""
alejandra "$package_path" packages/registry.nix
printf 'Created %s and registered packages.%s\n' "$package_path" "$package_name"

#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

machine_name=${1:-}
username=${2:-}
host_name=${3:-}
system=${4:-x86_64-linux}

if [[ -z "$machine_name" || -z "$username" || -z "$host_name" ]]; then
  printf 'Usage: new-machine <configuration> <username> <hostname> [system]\n' >&2
  exit 1
fi

validate_name "$machine_name"
validate_name "$username"
validate_name "$host_name"
if [[ "$system" != "x86_64-linux" && "$system" != "aarch64-linux" ]]; then
  printf 'Unsupported system: %s\n' "$system" >&2
  exit 1
fi

ensure_absent "hosts/$machine_name"

render templates/host.nix "hosts/$machine_name/default.nix" NEW_MACHINE_NAME "$machine_name" NEW_USERNAME "$username"
render templates/user-system.nix "hosts/$machine_name/users.nix" NEW_USERNAME "$username"
render templates/hardware.nix "hosts/$machine_name/hardware-configuration.nix"
render templates/metadata.nix "hosts/$machine_name/metadata.nix" NEW_MACHINE_NAME "$machine_name" NEW_USERNAME "$username" NEW_HOST_NAME "$host_name" NEW_SYSTEM "$system"

if [[ ! -e "users/$username" ]]; then
  render templates/user.nix "users/$username/home.nix" NEW_USERNAME "$username"
  render templates/user-default.nix "users/$username/default.nix"
fi

register_entry hosts/registry.nix "./$machine_name/metadata.nix"
alejandra "hosts/$machine_name" "users/$username" hosts/registry.nix
printf 'Created configuration %s for %s@%s\n' "$machine_name" "$username" "$host_name"

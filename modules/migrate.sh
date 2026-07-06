#!/usr/bin/env bash
set -euo pipefail # Strict error handling. Will immediately abort if any command fails.

cd /home/jin/.dotfiles/modules

# Safety: Create a complete backup of the modules directory first
cp -r . ../modules.bak
echo "Created backup at ../modules.bak"

declare -A cat_map=(
  ["hyprland"]="desktop" ["niri"]="desktop" ["mangowc"]="desktop" ["monitors"]="desktop" ["greetd"]="desktop" ["widgets"]="desktop"
  ["amd"]="hardware" ["intel"]="hardware" ["nvidia"]="hardware" ["audio"]="hardware" ["bluetooth"]="hardware" ["laptop"]="hardware" ["ups"]="hardware" ["camera"]="hardware" ["samson-q2u"]="hardware" ["opengl"]="hardware" ["via"]="hardware"
  ["common-universal"]="system" ["common-linux"]="system" ["dbus"]="system" ["nix-ld"]="system" ["secureboot"]="system" ["location"]="system" ["ssh"]="system" ["clamav"]="system" ["virtualize"]="system"
  ["btrfs"]="filesystem" ["zfs"]="filesystem" ["netfs"]="filesystem"
  ["discord"]="apps" ["obs"]="apps" ["zen"]="apps" ["kitty"]="apps" ["wezterm"]="apps" ["joplin"]="apps" ["nyxt"]="apps" ["mpv"]="apps" ["vscode"]="apps" ["unity"]="apps" ["dconf"]="apps"
  ["ai"]="tools" ["btop"]="tools" ["cava"]="tools" ["direnv"]="tools" ["git"]="tools" ["lazygit"]="tools" ["neofetch"]="tools" ["nix-index"]="tools" ["pentest"]="tools" ["shell"]="tools" ["yazi"]="tools" ["vpn"]="tools"
  ["gaming"]="gaming" ["steam"]="gaming" ["minecraft"]="gaming" ["ntsync"]="gaming" ["sunshine"]="gaming"
)

# Process nixos modules
if [ -d "nixos" ]; then
  for mod in $(ls nixos/); do
    cat=${cat_map[$mod]:-system}
    mkdir -p "$cat/$mod"
    rsync -a "nixos/$mod/" "$cat/$mod/"
    if [ -f "$cat/$mod/default.nix" ]; then
      mv "$cat/$mod/default.nix" "$cat/$mod/nixos.nix"
    fi
  done
fi

# Process home-manager modules
if [ -d "home-manager" ]; then
  for mod in $(ls home-manager/); do
    cat=${cat_map[$mod]:-apps}
    mkdir -p "$cat/$mod"
    rsync -a "home-manager/$mod/" "$cat/$mod/"
    if [ -f "$cat/$mod/default.nix" ]; then
      mv "$cat/$mod/default.nix" "$cat/$mod/home.nix"
    fi
  done
fi

# Cleanup
rm -rf nixos home-manager
echo "Migration completed successfully!"

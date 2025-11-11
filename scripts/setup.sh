#!/usr/bin/env bash
set -e

echo "Setting up development environment..."

if ! command -v direnv &> /dev/null || ! command -v pre-commit &> /dev/null; then
  echo "Error: 'direnv' or 'pre-commit' not found."
  echo "Please ensure you are running this script from within the Nix shell."
  echo "Try: nix develop -c ./scripts/setup.sh"
  exit 1
fi

echo "Installing Git pre-commit hooks for auto-formatting..."
pre-commit install

echo "Authorizing direnv to auto-load the environment..."
direnv allow

echo "Setup complete! The environment will now load automatically when you enter this directory."

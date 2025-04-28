#!/usr/bin/env bash

set -euo pipefail

dry_run=false

if [[ $# -eq 2 && "$1" == "--dry-run" ]]; then
  dry_run=true
  file="$2"
elif [[ $# -eq 1 ]]; then
  file="$1"
else
  echo "Usage: $0 [--dry-run] <package-list-file>"
  exit 1
fi

if [ ! -f "$file" ]; then
  echo "Error: File '$file' does not exist."
  exit 1
fi

packages=()
casks=()
zsh_plugins=()

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
PLUGIN_DIR="$ZSH_CUSTOM/plugins"

mkdir -p "$PLUGIN_DIR"

while IFS= read -r line || [[ -n "$line" ]]; do
  [[ -z "$line" || "$line" == \#* ]] && continue

  if [[ "$line" == cask:* ]]; then
    pkg="${line#cask:}"
    formula_name="${full_name##*/}"
    if brew list --cask --versions "$formula_name" >/dev/null 2>&1; then
      echo "Cask '$pkg' already installed, skipping."
    else
      casks+=("$pkg")
    fi

  elif [[ "$line" == zsh:* ]]; then
    repo="${line#zsh:}"
    plugin_name=$(basename "$repo" .git)
    if [ -d "$PLUGIN_DIR/$plugin_name" ]; then
      echo "Zsh plugin '$plugin_name' already installed, skipping."
    else
      zsh_plugins+=("$repo")
    fi

  else
    pkg="$line"
    if brew list --versions "$pkg" >/dev/null 2>&1; then
      echo "Package '$pkg' already installed, skipping."
    else
      packages+=("$pkg")
    fi
  fi
done < "$file"

if [ "$dry_run" = true ]; then
  echo
  echo "--- Dry Run ---"
  [ ${#packages[@]} -gt 0 ] && echo "Packages to install: ${packages[*]}"
  [ ${#casks[@]} -gt 0 ] && echo "Casks to install: ${casks[*]}"
  if [ ${#zsh_plugins[@]} -gt 0 ]; then
      for repo in "${zsh_plugins[@]}"; do
          plugin_name=$(basename "$repo" .git)
          echo "Zsh plugin to install: $plugin_name from $repo"
      done
  fi
  echo "---------------"
  exit 0
fi

[ ${#packages[@]} -gt 0 ] && brew install "${packages[@]}"
[ ${#casks[@]} -gt 0 ] && brew install --cask "${casks[@]}"

if [ ${#zsh_plugins[@]} -gt 0 ]; then
  for repo in "${zsh_plugins[@]}"; do
    plugin_name=$(basename "$repo" .git)
    git clone "$repo" "$PLUGIN_DIR/$plugin_name"
  done
fi

echo "All done."


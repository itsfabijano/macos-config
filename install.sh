#!/usr/bin/env bash

eval "$(/opt/homebrew/bin/brew shellenv)"

# Default value
installOnly=false

# Check all arguments for --installOnly
for arg in "$@"; do
    if [ "$arg" = "--installOnly" ]; then
        installOnly=true
        break
    fi
done

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh is not installed. Installing..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh is already installed."
fi

sh ./packages.sh packages.txt

# Exit early if installOnly is true
if [ "$installOnly" = true ]; then
    echo "installOnly is set to: $installOnly, exiting early"
    exit 0
fi

git submodule update --init --recursive

stow -t ~/ zsh ripgrep aerospace ghostty nvim ssh

# Settings for Aerospace
# Group MissionControl windows by application
defaults write com.apple.dock expose-group-apps -bool true && killall Dock

# Move windows by holding ctrl+cmd
defaults write -g NSWindowShouldDragOnGesture -bool true

git submodule update --remote --recursive

# INFO: This is probably not needed when installing with brew
# sudo ln -sf /Applications/UTM.app/Contents/MacOS/utmctl /usr/local/bin/utmctl

# Always show hidden files
defaults write com.apple.Finder AppleShowAllFiles true
killall Finder


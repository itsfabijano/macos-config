#!/usr/bin/env bash

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Oh My Zsh is not installed. Installing..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh is already installed."
fi

sh ./packages.sh packages.txt

git submodule update --init --recursive

stow zsh ripgrep aerospace ghostty nvim

# Settings for Aerospace
# Group MissionControl windows by application
defaults write com.apple.dock expose-group-apps -bool true && killall Dock

# Move windows by holding ctrl+cmd
defaults write -g NSWindowShouldDragOnGesture -bool true

git submodule update --remote --recursive


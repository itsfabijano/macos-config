#!/usr/bin/env bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sh ./packages.sh packages.txt

stow zsh ripgrep aerospace ghostty

# Settings for Aerospace
# Group MissionControl windows by application
defaults write com.apple.dock expose-group-apps -bool true && killall Dock

# Move windows by holding ctrl+cmd
defaults write -g NSWindowShouldDragOnGesture -bool true


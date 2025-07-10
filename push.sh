#!/bin/bash

# Commit and push submodules
git submodule foreach "
  git add .
  git commit -m 'Submodule changes'
  git push origin \$(git rev-parse --abbrev-ref HEAD)
"

# Commit and push the main repository
git add .
git commit -m "Updated submodules"
git push origin main


#!/usr/bin/env bash

# 
# https://github.com/dodie/testing-in-bash

if ! [ -x "$(command -v shellspec --version)" ]; then
  echo "⚙️ shellspec.info installation in progress..."
  # Install the latest stable version
  brew tap shellspec/shellspec
  brew install shellspec
fi
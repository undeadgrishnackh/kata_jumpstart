#!/usr/bin/env bash

if ! [ -x "$(command -v inspec --version)" ]; then
  echo "⚙️ inspec.io installation in progress..."
  curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec
fi

# ! NOTE: inspec requirement ruby > 2.4 
if ! [ -x "$(command -v ruby --version)" ]; then
  echo "⚙️ ruby installation in progress..."
  brew install ruby
fi
#!/usr/bin/env bash

# install inspec
if ! [ -x "$(command -v inspec --version)" ]; then
  curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec
fi

# ! NOTE: inspec requirement ruby > 2.4 
if ! [ -x "$(command -v ruby --version)" ]; then
  brew install ruby
fi

# remote exec 
# curl -s https://github.com/inspec/inspec/edit/master/test/unit/shell_detector_test.rb | inspec exec --interactive --color --enable-telemetry --show-progress
inspec exec ./test/jumpstart.spec.rb --interactive --color --enable-telemetry --show-progress

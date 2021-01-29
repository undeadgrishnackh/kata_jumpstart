#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${DIR}/../src/functions.inspec.sh


for i in {1..5}; do     
  inspec exec ${DIR}/_codacy.spec.rb --interactive --color --enable-telemetry --show-progress
  [[ $? -eq 0 ]] && break || echo "\n⏱️  it can take a while to create the project in Codacy...";
  echo "⏱️  next try in 60 seconds"    
  sleep 60
done

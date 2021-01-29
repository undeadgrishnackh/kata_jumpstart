#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${DIR}/../src/functions.inspec.sh


for i in {1..6}; do     
  inspec exec ${DIR}/_sonarcloud.spec.rb --interactive --color --enable-telemetry --show-progress
  [[ $? -eq 0 ]] && break || echo "⏱️  it can take a while to create the project in SonarCloud...";    
  echo "⏱️  next try in 10 seconds"    
  sleep 10
done


#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${DIR}/../src/functions.inspec.sh


inspec exec ${DIR}/_jumpstart.spec.rb --interactive --color --enable-telemetry --show-progress
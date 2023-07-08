#!/usr/bin/env bash
#
# Run ./app.sh for usage information.
#

set -e
set -o pipefail

function debug() {
  trap 'printf -- "-- \033[0;36m${BASH_COMMAND}\033[0m\n"' DEBUG
}

command=$1

if [[ $command == "build" ]]; then
  debug
  ./test/git-autopush
  exit 0
fi

if [[ -z $command ]]; then
  echo "Unknown command: ${command}"
fi

echo "Usage: $0 <command>"
echo "Commands:"
echo "  build            -- verify test scenarios"

exit 1

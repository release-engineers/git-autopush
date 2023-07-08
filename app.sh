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

  # generate a project from the template
  sources=$(pwd)
  test_target=$(mktemp -d)
  trap 'rm -rf "${test_target}"' EXIT

  # set up two git repositories and run git-autopush
  mkdir -p "${test_target}/local"
  mkdir -p "${test_target}/origin"
  cd "${test_target}/local"
  git init
  git init --bare "${test_target}/origin"
  git remote add origin "file://${test_target}/origin/"
  echo "Hello" > README.md
  ${sources}/bin/git-autopush

  # verify that a commit was pushed mentioning the new README
  cd "${test_target}/origin"
  git log --oneline | grep "README"

  exit 0
fi

if [[ -z $command ]]; then
  echo "Unknown command: ${command}"
fi

echo "Usage: $0 <command>"
echo "Commands:"
echo "  build            -- verify a git-autocommit scenario"

exit 1

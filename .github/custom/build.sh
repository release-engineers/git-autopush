#!/usr/bin/env bash

set -e
set -o pipefail
trap 'printf -- "-- \033[0;36m${BASH_COMMAND}\033[0m\n"' DEBUG

# add local bin directory to PATH
export PATH="$(pwd)/bin:${PATH}"

# set up two git repositories and run `git autopush`
test_target=$(mktemp -d)
trap 'rm -rf "${test_target}"' EXIT
mkdir -p "${test_target}/local"
mkdir -p "${test_target}/origin"
cd "${test_target}/local"
git init
git init --bare "${test_target}/origin"
git remote add origin "file://${test_target}/origin/"
echo "Hello" > README.md
git config --local user.name 'github-actions[bot]'
git config --local user.email 'github-actions[bot]@users.noreply.github.com'
git autopush

# verify that a commit was pushed mentioning the new README
cd "${test_target}/origin"
git log --oneline | grep "README"

# git-autopush

[![Status: Production ready](https://img.shields.io/badge/status-production_ready-green)](https://release-engineers.com/open-source-badges/)

Utilities for working with commits when commit messages don't matter.

| Script                               | Description                                                                |
|--------------------------------------|----------------------------------------------------------------------------|
| [git changes](bin/git-changes)       | Prints a list of files or directories changed since the last commit.       |
| [git prefix](bin/git-prefix)         | Prints a prefix for a commit message.                                      |
| [git autocommit](bin/git-autocommit) | Stages the repository directory and commits using above commands.          |
| [git autopush](bin/git-autopush)     | `git autocommit`s. Then fetches, rebases and pushes that commit to origin. |

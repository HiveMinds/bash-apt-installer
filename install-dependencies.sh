#!/usr/bin/env bash

# Remove the submodules if they were still in the repo.
git rm --cached test/libs/bats
git rm --cached test/libs/bats-support
git rm --cached test/libs/bats-assert
git rm --cached dependencies/bash-log

# Remove and re-create the submodule directory.
rm -r test/libs
mkdir -p test/libs

# Remove and create a directory for the dependencies.
rm -r dependencies
mkdir -p dependencies/bash-log

# (Re) add the BATS submodules to this repository.
git submodule add --force https://github.com/sstephenson/bats test/libs/bats
git submodule add --force https://github.com/ztombol/bats-support test/libs/bats-support
git submodule add --force https://github.com/ztombol/bats-assert test/libs/bats-assert
git submodule add --force https://github.com/HiveMinds/bash-log dependencies/bash-log

# Get the latest commits of those submodules.
git submodule update --remote --recursive

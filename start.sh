#!/bin/sh

echo "Starting updating submodules"
git submodule update --init --recursive

echo "Starting setting bash environment ..."
./setting_bash.sh

echo "Starting setting git environment ..."
./setting_git.sh

echo "Setup gecko-dev"
./setup_gecko.sh

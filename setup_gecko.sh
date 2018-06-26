#!/bin/sh

PROJECTS_PATH="$HOME/Projects"
GECKO_PATH="$PROJECTS_PATH/gecko-dev"

echo "Creating the project directory"

if [ ! -d "$PROJECTS_PATH" ]; then
  mkdir "$HOME/Projects"
fi

if [ -d "$GECKO_PATH" ]; then
  echo "The gecko-dev exists, we don't need to initalize here."
  exit 0
fi

arc install-certificate

echo "Starting initalizing gecko-dev"

git init "$GECKO_PATH"
cd "$GECKO_PATH"

git config fetch.prune true
git config push.default upstream
git remote add mozilla hg::https://hg.mozilla.org/mozilla-unified -t bookmarks/central
git remote set-url --push mozilla hg::ssh://hg.mozilla.org/integration/mozilla-inbound
git config remote.mozilla.fetch +refs/heads/bookmarks/*:refs/remotes/mozilla/*
git remote add try hg::https://hg.mozilla.org/try
git config remote.try.skipDefaultUpdate true
git remote set-url --push try hg::ssh://hg.mozilla.org/try
git config remote.try.push +HEAD:refs/heads/branches/default/tip

# Setup watchman
# mv .git/hooks/fsmonitor-watchman.sample .git/hooks/query-watchman
# git config core.fsmonitor .git/hooks/query-watchman

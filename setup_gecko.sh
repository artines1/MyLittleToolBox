#!/bin/sh

echo "Starting initalizing gecko-dev"

git init gecko-dev
cd gecko-dev

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

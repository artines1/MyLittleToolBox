#!/bin/sh

GIT_USER_NAME="Tim Huang"
GIT_EMAIL="tihuang@mozilla.com"

echo "Setup the username and email ..."
git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_EMAIL"

echo "Setup diff-so-fancy ..."
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global color.ui true
git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"
git config --global color.diff.meta       "yellow"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"

echo "Installing the Stacked Git ..."
brew install stgit



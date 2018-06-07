#!/bin/sh

GIT_USER_NAME="Tim Huang"
GIT_EMAIL="tihuang@mozilla.com"

echo "Setup the username and email..."

git config --global user.name "$GIT_USER_NAME"
git config --global user.email "$GIT_EMAIL"


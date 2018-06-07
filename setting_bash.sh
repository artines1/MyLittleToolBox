#!/bin/sh

# Folders for adding into PATH
PATH_DIRS=("git-cinnabar" "diff-so-fancy")

echo "Installing homebrew ..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing Git ..."
brew install git

echo "Installing bash completion ..."
brew install bash-completion

echo "Creating bashrc and bash_profile ..."
# Setup the alias
echo "alias ls='ls -FG'" >> ${HOME}/.bashrc
# Setup the PATH.
echo "export PATH=" >> ${HOME}/.bashrc
for dir in "${PATH_DIRS[@]}"
do
  echo ${PWD}/$dir: >> ${HOME}/.bashrc
done
echo "\$PATH\n" >> ${HOME}/.bashrc
# Setup for the bash completion.
printf "%s\n" "if [ -f `brew --prefix`/etc/bash_completion ]; then" "  . `brew --prefix`/etc/bash_completion" "fi" >> ${HOME}/.bashrc
# Setup for both login and non-login sessions.
printf "%s\n" "if [ -f $HOME/.bashrc ]; then" "  source $HOME/.bashrc" "fi" >> ${HOME}/.bash_profile



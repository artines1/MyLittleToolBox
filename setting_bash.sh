#!/bin/sh

# Folders for adding into PATH
PATH_DIRS=("git-cinnabar" "diff-so-fancy")
TOOLS_PATH="$HOME/Tools"

echo "Installing homebrew ..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing Git ..."
brew install git

echo "Installing bash completion ..."
brew install bash-completion

echo "Installing git cinnabar ..."
if [ ! -d "$TOOLS_PATH" ]; then
  mkdir $TOOLS_PATH
fi
git clone https://github.com/glandium/git-cinnabar.git "$TOOLS_PATH/git-cinnabar"
git --git-dir="$TOOLS_PATH/git-cinnabar" submodule update --init --recursive

echo "Install the requests module for git cinnabar..."
pip install requests

echo "Download the git cinnabar helper ..."
git cinnabar download

echo "Installing the bash-git-prompt"
git clone https://github.com/magicmonty/bash-git-prompt.git ${HOME}/.bash-git-prompt --depth=1

echo "Creating bashrc and bash_profile ..."
# Setup the alias
echo "alias ls='ls -FG'" >> ${HOME}/.bashrc
# Setup the PATH.
TEMP_PATH="\$PATH\n"
echo "export PATH=" >> ${HOME}/.bashrc
for dir in "${PATH_DIRS[@]}"
do
  TEMP_PATH="${PWD}/$dir:${TEMP_PATH}"
done
echo $TEMP_PATH >> ${HOME}/.bashrc
# Setup for the bash completion.
printf "%s\n" "if [ -f `brew --prefix`/etc/bash_completion ]; then" "  . `brew --prefix`/etc/bash_completion" "fi" >> ${HOME}/.bashrc
# Setup for the bash-git-prompt
echo "GIT_PROMPT_ONLY_IN_REPO=1" >> ${HOME}/.bashrc
echo "source ${HOME}/.bash-git-prompt/gitprompt.sh" >> ${HOME}/.bashrc
# Setup for cargo.
echo "source ${HOME}/.cargo/env" >> ${HOME}/.bashrc
# Setup for both login and non-login sessions.
printf "%s\n" "if [ -f $HOME/.bashrc ]; then" "  source $HOME/.bashrc" "fi" >> ${HOME}/.bash_profile



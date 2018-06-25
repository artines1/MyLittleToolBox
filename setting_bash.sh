#!/bin/sh

# Folders for adding into PATH
PATH_DIRS=("git-cinnabar" "diff-so-fancy")
TOOLS_PATH="$HOME/Tools"

echo "Installing homebrew ..."
if hash brew; then
  echo "Homebrew has been installed ..."
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing macvim ..."
if brew ls --versions myformula > /dev/null; then
  echo "Macvim has been installed ..."
else
  brew install macvim --with-override-system-vim
fi

echo "Installing Git ..."
brew install git

echo "Installing Mercurial ..."
brew install mercurial

echo "Installing bash completion ..."
brew install bash-completion

echo "Installing pip ..."
if hash pip; then
  echo "Pip has been installed ..."
else
  sudo easy_install pip
fi

echo "Install the requests module for git cinnabar..."
sudo -H pip install requests

echo "Installing the bash-git-prompt"
if [ -d "${HOME}/.bash-git-prompt" ]; then
  echo "The bash-git-prompt has been installed ..."
else
  git clone https://github.com/magicmonty/bash-git-prompt.git ${HOME}/.bash-git-prompt --depth=1
fi

echo "Creating bashrc and bash_profile ..."
createBashrc ()
{
  # Setup the alias
  echo "alias ls='ls -FG'" >> ${HOME}/.bashrc
  # Setup the PATH.
  TEMP_PATH="\$PATH\n"
  for dir in "${PATH_DIRS[@]}"
  do
    TEMP_PATH="${PWD}/$dir:${TEMP_PATH}"
  done
  echo "export PATH=${TEMP_PATH}" >> ${HOME}/.bashrc
  # Setup for the bash completion.
  printf "%s\n" "if [ -f `brew --prefix`/etc/bash_completion ]; then" "  . `brew --prefix`/etc/bash_completion" "fi" >> ${HOME}/.bashrc
  # Setup for the bash-git-prompt
  echo "GIT_PROMPT_ONLY_IN_REPO=1" >> ${HOME}/.bashrc
  echo "source ${HOME}/.bash-git-prompt/gitprompt.sh" >> ${HOME}/.bashrc
  # Setup for cargo.
  echo "source ${HOME}/.cargo/env" >> ${HOME}/.bashrc
}

createBashProfile ()
{
  # Setup for both login and non-login sessions.
  printf "%s\n" "if [ -f $HOME/.bashrc ]; then" "  source $HOME/.bashrc" "fi" >> ${HOME}/.bash_profile
}

if [ ! -f ${HOME}/.bashrc ]; then
  createBashrc
else
  echo "The bachrc file already exists ..."
fi

if [ ! -f ${HOME}/.bash_profile ]; then
  createBashProfile
else
  echo "The bash profile file already exists ..."
fi



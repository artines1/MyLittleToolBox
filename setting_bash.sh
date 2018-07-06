#!/bin/sh

# Folders for adding into PATH
PATH_DIRS=("git-cinnabar" "diff-so-fancy")
TOOLS_PATH="$HOME/Tools"
PHABRICATOR_PATH="${TOOLS_PATH}/Phabricator"

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

echo "Install Phabricator ..."
if [ -d "${PHABRICATOR_PATH}" ]; then
  echo "Phabricator has been installed ..."
else
  mkdir ${PHABRICATOR_PATH}
  git clone https://github.com/phacility/libphutil.git "${PHABRICATOR_PATH}/libphutil"
  git clone https://github.com/mozilla-conduit/arcanist.git "${PHABRICATOR_PATH}/arcanist"
fi

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
  # Add the path for phabricator
  TEMP_PATH="${PHABRICATOR_PATH}/arcanist/bin:${TEMP_PATH}"
  # Add the path for my own libaray
  TEMP_PATH="${PWD}/bin:${TEMP_PATH}"
  echo "export PATH=${TEMP_PATH}" >> ${HOME}/.bashrc
  # Setup for the bash completion.
  printf "%s\n" "if [ -f `brew --prefix`/etc/bash_completion ]; then" "  . `brew --prefix`/etc/bash_completion" "fi" >> ${HOME}/.bashrc
  echo "\n" >> ${HOME}/.bashrc
  # Setup for the git completion.
  printf "%s\n" "if [ -f `brew --prefix stgit`/share/stgit/completion/stgit-completion.bash ]; then" "  . `brew --prefix`/share/stgit/completion/stgit-completion.bash" "fi" >> ${HOME}/.bashrc
  echo "\n" >> ${HOME}/.bashrc
  # Setup for the bash-git-prompt
  echo "GIT_PROMPT_ONLY_IN_REPO=1" >> ${HOME}/.bashrc
  echo "source ${HOME}/.bash-git-prompt/gitprompt.sh" >> ${HOME}/.bashrc
  # Setup for cargo.
  echo "source ${HOME}/.cargo/env" >> ${HOME}/.bashrc
  echo "\n" >> ${HOME}/.bashrc

  # Add ssh keys
  echo "# Add ssh key" >> ${HOME}/.bashrc
  echo "for key in \$HOME/.ssh/*" >> ${HOME}/.bashrc
  echo "do" >> ${HOME}/.bashrc
  echo "if [ -f \${key}.pub ]; then" >> ${HOME}/.bashrc
  echo "  /usr/bin/ssh-add -K \$key > /dev/null 2>&1" >> ${HOME}/.bashrc
  echo "fi" >> ${HOME}/.bashrc
  echo "done" >> ${HOME}/.bashrc
  echo "\n" >> ${HOME}/.bashrc

  # Setup the default editor
  echo "export EDITOR='vim'" >> ${HOME}/.bashrc
  echo "\n" >> ${HOME}/.bashrc
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



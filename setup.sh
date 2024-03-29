#!/bin/sh

setup_oh_my_zsh(){
  # Install oh my zsh
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # Add auto suggestions plugin
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

  # Add syntax highlighting pulgin
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

  # pulling down .zshrc to local env
  curl https://raw.githubusercontent.com/lennee/environment-config/main/.zshrc -o $1/.zshrc

  # Final themeing update to set only 2 directories shown in the clie
  sed -i '.original' $'s//Users/tristansmith/${1}' $1/.zshrc
  sed -i '.original' "12s/.*/local current_dir='%{$terminfo[bold]$fg[blue]%}%2~ %{$reset_color%}'/" ~/.oh-my-zsh/themes/robbyrussell.zsh-theme

  source ~/.zshrc
}

setup_package_manager()
{
  if [[ "`uname`" == "Linux" ]]; then
    pacman -Syu
    HOME_DIR="/home/tristan"
  elif [[ "`uname`" == "Darwin" ]]; then
    which -s brew
    if [[ $? != 0 ]] ; then
        # Install Homebrew
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        brew update
    fi
    HOME_DIR="~"
  fi
}

create_directories(){
  mkdir '~/Documents/Music Projects'
  mkdir '~/Documents/git-repos'
}

#setup_package_manager

which -s git
if [[ $? != 0 ]] ; then
  echo "Install git then run script again"
  exit 0
fi

# set git init default branch to main
git config --global init.defaultBranch main

#installs/install.sh

setup_oh_my_zsh ${HOME_DIR}

create_directories



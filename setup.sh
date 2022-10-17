#!/usr/bin/env sh

source functions.sh

info "Getting sudo credentials"
if sudo -v; then
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
else
    error "Failed to obtain sudo credentials"
    exit 1
fi

info "Installing XCode command line tools"
if ! xcode-select --print-path &> /dev/null; then
  if xcode-select --install; then
      success "Installed XCode command line tools"
  else
      error "Failed to install XCode command line tools"
      exit 1
  fi
else
  success "XCode command line tools already installed"
fi

info "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> ~/.zprofile
eval $(/opt/homebrew/bin/brew shellenv)
info "Disabling Hombrew analytics"
brew analytics off

info "Installing Homebrew packages"
brew bundle
info "Cleaning up Homebrew files"
brew cleanup

info "Setting fish shell as default"
if [[ ! $(echo $SHELL) == $(which fish) ]]; then
  fish_shell="$(which fish)"
  etc_shells="/etc/shells"
  grep $fish_shell /etc/shells > /dev/null || echo $fish_shell | sudo tee -a $etc_shells
  chsh -s $fish_shell
else
  success "Fish is already default shell"
fi

source update-symlinks.sh
#source macos.sh

info "Installing Oh-My-Fish"
curl -L https://get.oh-my.fish > install_omf
fish install_omf --noninteractive --yes
rm install_omf

info "Building fish auto-completions from mans"
fish -c 'fish_update_completions'

info "Installing SpaceVim"
curl -sLf https://spacevim.org/install.sh | bash

success ">>> Battlecruiser operational <<<"
fish

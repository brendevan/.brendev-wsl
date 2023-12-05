#!/bin/bash
source $BDEV/helpers/setup_helpers.sh 
source $BDEV/helpers/r_helpers.sh 

msg-h1 "SETTING UP TERMINAL"
msg-h2 "Installing zsh"
sudo apt update -y && sudo apt install -y zsh

msg-h2 "Installing oh-my-zsh and extensions"
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


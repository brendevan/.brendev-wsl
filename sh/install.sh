#!/bin/bash

# ===================
#    apt packages
# ===================
sudo apt update -y  && sudo apt install -y  \
  curl                                      \
  git                                       \
  zsh                                       \
  zsh-syntax-highlighting                   \
  zsh-autosuggestions

# ===================
#     oh-my-zsh
# ===================
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ===================
#      codium
# ===================
sudo snap install codium --classic


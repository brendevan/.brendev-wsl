#!/bin/bash

# ===================
#    apt packages
# ===================
sudo apt update -y  && sudo apt install -y  \
  curl                                      \
  git                                       \
  pandoc                                    \
  python3-pip                               \
  zsh                                       


# ===================
#     oh-my-zsh
# ===================
# oh-my-zsh
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# ===================
#       codium
# ===================
sudo snap install codium --classic

# ===================
#          R
# ===================
# radian console
RUN pip3 install -U radian


#!/bin/bash

# ===================
#    apt packages
# ===================
sudo apt update -y  && sudo apt install -y  \
  curl                                      \
  git                                       \
  gdebi-core                                \
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
# R language
yes | sudo bash $BDEV/sh/install_r.sh
# radian console
sudo pip3 install -U radian
# jupyter  (used by quarto)
sudo pip3 install -U jupyter
# quarto  (install with gdebi)
# from: https://docs.posit.co/resources/install-quarto/#quarto-deb-file-install
yes | sudo curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb
yes | sudo gdebi quarto-linux-amd64.deb
/usr/local/bin/quarto check
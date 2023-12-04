#!/bin/bash
source $BDEV/sh/helper.sh
msg "\n🦑 INSTALLING SOFTWARE"

# ======================================
#             Apt packages
# ======================================
msg "   - apt packages"
sudo apt-get update -y  && sudo apt-get install -y  \
  curl                                              \
  git                                               \
  gdebi-core                                        \
  pandoc                                            \
  python3-pip                                       \
  zsh                                       

# ======================================
#               Oh-my-zsh
# ======================================
# oh-my-zsh
msg "   - oh-my-zsh and plugins"
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting



# ======================================
#                Quarto
# ======================================
# jupyter  (used by quarto)                   ****REMOVED SUDO, NOT YET TESTED
msg "   - jupyter"
pip3 install -U jupyter                       
# quarto  
msg "   - quarto"
# if not already installed, download deb file and install with gdebi
# method from : https://docs.posit.co/resources/install-quarto/#quarto-deb-file-install
if ! quarto check --quiet; then
  yes | sudo curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb
  yes | sudo gdebi quarto-linux-amd64.deb
  sudo rm quarto-linux-amd64.deb
fi
quarto check

# ======================================
#           VS code extensions
# ======================================
msg "   - vs code extensions"
sudo bash $BDEV/sh/vscode.sh


# ===================
#        fin
# ===================
msg " Finished installs! 🐳"
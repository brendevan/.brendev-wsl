#!/bin/bash

# Note: ln (create link) -s (--symbolic) -f (--force)

# ====================
#      Terminal 
# ====================
ln -sf ~/brendev-wsl/dotfiles/.bash_aliases      ~/.bash_aliases
ln -sf ~/brendev-wsl/dotfiles/.bashrc            ~/.bashrc
ln -sf ~/brendev-wsl/dotfiles/.zshrc             ~/.zshrc
ln -sf ~/brendev-wsl/dotfiles/.zsh-theme         "$ZSH/themes/brendev.zsh-theme"

# ====================
#         R 
# ====================
ln -sf ~/.dotfiles/dotfiles/.Rprofile                     ~/.Rprofile

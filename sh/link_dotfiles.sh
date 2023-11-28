#!/bin/bash

# Note: ln (create link) -s (--symbolic) -f (--force) -T (always treat link as file)

# ====================
#      Terminal 
# ====================
ln -sf ~/.brendev-wsl/dotfiles/.bash_aliases      ~/.bash_aliases
ln -sf ~/.brendev-wsl/dotfiles/.bashrc            ~/.bashrc 
ln -sf ~/.brendev-wsl/dotfiles/.zshrc             ~/.zshrc
ln -sf ~/.brendev-wsl/dotfiles/.zsh-theme         ~/.oh-my-zsh/themes/brendev.zsh-theme

# ====================
#         R 
# ====================
ln -sf ~/.brendev-wsl/dotfiles/.Rprofile          ~/.Rprofile

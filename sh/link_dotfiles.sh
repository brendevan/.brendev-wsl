#!/bin/bash

# Note: ln (create link) -s (--symbolic) -f (--force) -T (always treat link as file)

# ====================
#      Terminal 
# ====================
ln -sf $BDEV/dotfiles/.bash_aliases      ~/.bash_aliases
ln -sf $BDEV/dotfiles/.bashrc            ~/.bashrc 
ln -sf $BDEV/dotfiles/.zshrc             ~/.zshrc
ln -sf $BDEV/dotfiles/.zsh-theme         ~/.oh-my-zsh/themes/brendev.zsh-theme

# ====================
#         R 
# ====================
ln -sf $BDEV/dotfiles/.Rprofile          ~/.Rprofile

#!/bin/bash


# ====================================
#           DOTFILE FOLDERS
# ====================================
msg-h1 "🐡 SETTING UP DOTFILES (as symbolic links)"

# Path to code folder where settings are stored
CODE_DFF=$HOME/.config/Code/User

# ====================================
#          DOTFILES TO SETUP 
# ====================================
# LINK: Where to create symbolic link to dotfile:
BASHRC=$HOME/.bashrc
BASH_ALIASES=$HOME/.bash_aliases
ZSHRC=$HOME/.zshrc
ZSH_THEME=$HOME/.oh-my-zsh/themes/brendev.zsh-theme
RPROFILE=$HOME/.RProfile
CODE_SETTINGS=$CODE_CONF/settings.json
CODE_KEYBINDS=$CODE_CONF/keybindings.json
CODE_SNIPPETS=$CODE_CONF/snippets/bdev.code-snippets

# ====================================
#            LINK DOTFILES
# ====================================
msg-h2 "Terminal:"; 
bdev-link-dotfile $BDEV/dotfiles/.bash_aliases  $BASH_ALIASES
bdev-link-dotfile $BDEV/dotfiles/.bashrc        $BASHRC      
bdev-link-dotfile $BDEV/dotfiles/.zshrc         $ZSHRC       
bdev-link-dotfile $BDEV/dotfiles/.zsh-theme     $ZSH_THEME      

msg-h2 "R:"
bdev-link-dotfile $BDEV/dotfiles/.RProfile      $RPROFILE

msg-h2 "(VS)code:"
bdev-link-dotfile $BDEV/dotfiles/.code/settings.json      $CODE_SETTINGS
bdev-link-dotfile $BDEV/dotfiles/.code/keybindings.json   $CODE_KEYBINDS
bdev-link-dotfile $BDEV/dotfiles/.code/bdev.code-snippets $CODE_SNIPPETS

# ====================
#        fin
# ====================
msg "Finished dotfile setup! 🐳"
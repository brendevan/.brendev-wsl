#!/bin/bash
source $BDEV/sh/helper.sh
msg "\n🐡 SETTING UP DOTFILES (as symbolic links)"; sleep 1

# Note: ln (create link) -s (--symbolic) -f (--force) -T (always treat link as file)

# DOTFILES TO SETUP 
BASHRC=~/.bashrc
BASH_ALIASES=~/.bash_aliases
ZSHRC=~/.zshrc
ZSH_THEME=~/.oh-my-zsh/themes/brendev.zsh-theme
RPROFILE=~/.Rprofile
CODE_SETTINGS=~/.code/settings.json
CODE_KEYBINDS=~/.code/keybindings.json
CODE_SNIPPETS=~/.code/snippets.code-snippets

# ====================
#      Terminal 
# ====================
msg "Terminal:"; 
# msg "   - $BASH_ALIASES";   ln -sf $BDEV/dotfiles/.bash_aliases      $BASH_ALIASES
# msg "   - $BASHRC";         ln -sf $BDEV/dotfiles/.bashrc            $BASHRC        
# msg "   - $ZSHRC";          ln -sf $BDEV/dotfiles/.zshrc             $ZSHRC        
# msg "   - $ZSH_THEME"l;     ln -sf $BDEV/dotfiles/.zsh-theme         $ZSH_THEME  
bdev-link-dotfile $BDEV/dotfiles/.bash_aliases  $BASH_ALIASES
bdev-link-dotfile $BDEV/dotfiles/.bashrc        $BASHRC      
bdev-link-dotfile $BDEV/dotfiles/.zshrc         $ZSHRC       
bdev-link-dotfile $BDEV/dotfiles/.zsh-theme     $ZSH_THEME      
sleep 2

# ====================
#         R 
# ====================
msg "R:"
# msg "   - $RPROFILE";       ln -sf $BDEV/dotfiles/.Rprofile          $RPROFILE
bdev-link-dotfile $BDEV/dotfiles/.Rprofile      $RPROFILE
sleep 2

# ====================
#    VS Code/Codium
# ====================
msg "(VS)code & codium:"
test ! ~/.code && mkdir ~/.code
# msg "   - $CODE_SETTINGS";  ln -sf $BDEV/dotfiles/.code/settings.json           $CODE_SETTINGS
# msg "   - $CODE_KEYBINDS";  ln -sf $BDEV/dotfiles/.code/keybindings.json        $CODE_KEYBINDS
# msg "   - $CODE_SNIPPETS";  ln -sf $BDEV/dotfiles/.code/snippets.code-snippets  $CODE_SNIPPETS
bdev-link-dotfile $BDEV/dotfiles/.code/settings.json           $CODE_SETTINGS
bdev-link-dotfile $BDEV/dotfiles/.code/keybindings.json        $CODE_KEYBINDS
bdev-link-dotfile $BDEV/dotfiles/.code/snippets.code-snippets  $CODE_SNIPPETS

# ====================
#        fin
# ====================
msg "Finished dotfile setup! 🐳"
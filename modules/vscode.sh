#!/bin/bash
source $BDEV/helpers/setup_helpers.sh
source $BDEV/helpers/vscode_helpers.sh
source $BDEV/dotfiles/.code/.extensions
source $BDEV/dotfiles/.code/.themes

msg-h1 "VSCODE SETUP"
msg-h2 "No vscode install required for WSL (windows only)"
msg-h2 "Installing vscode extensions"
source $BDEV/dotfiles/.code/.extensions
vscode-install-extensions "${extensions[@]}"
msg-h2 "Installing vscode themes"
vscode-install-extensions "${themes[@]}"

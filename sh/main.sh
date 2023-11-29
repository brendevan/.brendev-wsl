#!/bin/bash

# ======================================
#     BRENDEV-WSL SETUP: MAIN SCRIPT
# ======================================
# This is the main script for setting up my wsl-ubuntu environment
#  - Install programs with install.sh (which calls other install scripts)
#  - Setup config/dotfiles with link_dotfiles.sh

# =====================
#    !! ATTENTION !!
# =====================
# Edit this path if cloning .brendev-wsl to somewhere other than $HOME
BDEV="$HOME/.brendev-wsl"


# =====================
#        START 
# =====================
# Load helper functions
source $BDEV/sh/helper.sh

# Start progress messages to console
msg-start

# Export path to .brendev-wsl as environment variable (persist by adding to .bashrc)
bdev-export "$BDEV"

# Run setup scripts
bdev-install
bdev-dotfiles

msg "\nFINISHED! 🐳"
msg "brendev should now be setup"
msg-stop

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
# Log into sudo
sudo :
# Load helper functions
source $BDEV/sh/helper.sh
# Cleanup temp files left from previous failed runs
bdev-cleanup
# Start progress messages to console
msg-start

# Export path to .brendev-wsl as environment variable (persist by adding to .bashrc)
bdev-export "$BDEV"

msg "\n🦑 INSTALLING SOFTWARE"

# Run setup scripts
source $BDEV/modules/r.sh


msg " Finished installs! 🐳"
# bdev-dotfiles

# Print final messages and cleanup (stop)
msg "\nFINISHED! 🐳"
msg "brendev should now be setup"
msg-stop

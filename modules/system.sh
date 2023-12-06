#!/bin/bash

# ======================================
#         Install system packages
# ======================================
# The system packages are listed in dotfiles/.SystemPackages
# Here we install them with apt-get
msg-h1 "SYSTEM PACKAGES"
source $BDEV/dotfiles/.SystemPackages
sudo apt-get update -y  && sudo apt-get install -y ${BDEV_SYS_PACKAGES[@]}                   


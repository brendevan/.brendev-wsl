#!/bin/bash

# !! Edit this path if cloning .brendev-wsl to somewhere other than $HOME !!
BDEV="$HOME/.brendev-wsl"


# Export path to .brendev-wsl as environment variable (persist by adding to .bashrc)
export BDEV=$BDEV
echo -e 'export BDEV="$HOME/.brendev-wsl"' | \
  sudo tee -a $HOME/.brendev-wsl/dotfiles/.bashrc

# Run setup scripts
bash $BDEV/sh/install.sh
bash $BDEV/sh/link_dotfiles.sh

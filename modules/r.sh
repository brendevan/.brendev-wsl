#!/bin/bash

# =====================================
#               INSTALL R
# =====================================
# From: https://cran.csiro.au/
msg-h1 "R PROGRAMMING LANGUAGE"

msg-h2 "Telling Ubuntu about the R binaries at CRAN"
sudo apt-get update -qq  # update indices
sudo apt-get install --no-install-recommends software-properties-common dirmngr  # install dependencies
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | \
  sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc # Add the signing key (by Michael Rutter) for these repos. To verify key, run `gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc`. Fingerprint: 298A3A825C0D65DFD57CBB651716619E084DAB9
yes | \
  sudo add-apt-repository \
  "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" # Add the R 4.0 repo from CRAN -- adjust 'focal' to 'groovy' or 'bionic' as needed

msg-h2 "Installing R and its dependencies"
sudo apt-get install --no-install-recommends r-base r-base-dev
# Note: r-base-dev to compile R packages from source (incl. with install.packages())

# =====================================
#        INSTALL RADIAN CONSOLE
# =====================================
msg-h2 "Installing radian console"
pip3 install -U radian

# =====================================
#          INSTALL R PACKAGES
# =====================================
msg-h1 "INSTALLING R PACKAGES\n"
source $BDEV/dotfiles/.RPackages
# Ensure apt knows about CRAN repositories
rpkgs-ensure-ppas
# Remotes package required for installing from github
rpkgs-install-and-msg remotes
for PKG in "${BDEV_R_PACKAGES[@]}"; do
  rpkgs-install-and-msg $PKG
done

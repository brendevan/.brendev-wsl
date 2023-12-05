#!/bin/bash

# ==========================================
#           BDEV BASH FUNCTIONS 
# ==========================================

# =========================
#          ALIASES
# =========================

test () {
  echo "$@"
}


# User facing functions to be moved to .bdev_aliases
bdev-build () {
  source $BDEV/bdev.sh
  # if [ ! "$1" ]
  #   then BDEV=$HOME/.brendev-wsl
  #   else BDEV=$1/.brendev-wsl
  # fi
  # source $BDEV/sh/helper.sh
  # bdev-log 
  msg-start
  # source $BDEV/modules/apt.sh
  # source $BDEV/modules/terminal.sh
  source $BDEV/modules/r.sh



  msg-stop
}

# ============================================
#    BDEV: helper functions for bdev setup 
# ============================================
bdev-export () {
  msg "\n🦈 Setting BDEV environment variable to $1"
  EXPORT_BDEV="export BDEV=$1"
  # Export BDEV for current shell
  eval $EXPORT_BDEV
  # Export BDEV in bashrc for all future shells 
  # (after deleting previous export BDEV bashrc lines)
  sed -i '/export BDEV=/d' dotfiles/.bashrc
  echo -e  $EXPORT_BDEV | \
    sudo tee -a $HOME/.brendev-wsl/dotfiles/.bashrc
}
bdev-install () {
  bash $BDEV/sh/install.sh
}
bdev-dotfiles () {
  bash $BDEV/sh/dotfiles.sh
}
bdev-link-dotfile () {
  TARGET=$1
  LINK=$2
  sleep 1
  msg "   - $LINK"
  ln -sf $TARGET $LINK
}
bdev-log () {
  eval $1 2>&1 | tee .run-log.txt
}
bdev-cleanup () {
  rm -rf .msg-temp
}

# =================================================
#    MSG: Print progress messages for BDEV setup
# =================================================
BANNER="\
=======================================================\n\
 🐟 SETTING UP BREN(dan's)DEV(elopment environment) 🐟 \n\
======================================================="
CYAN='\033[0;36m'
BLUE='\033[0;34m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NOCOL='\033[0m'
MSG_TEMP_FILE=$BDEV/.msg-temp
msg () {
  # Read in previously created MSG
  MSG=$(<$MSG_TEMP_FILE)
  # Display message
  clear
  echo -e "${CYAN}$MSG\n${BLUE}$1${NOCOL}\n"
  # Write additions to file
  MSG="$MSG\n$1"
  echo -e "$MSG" > $MSG_TEMP_FILE
}
msg-h1 () {
  msg "   • $1"
} 
msg-h2 () {
  msg "      - $1"
}
msg-start () {
  # Garbage collection
  test -f $MSG_TEMP_FILE && msg-stop
  # Export path to MSG temporary storage file
  export MSG_TEMP_FILE=$MSG_TEMP_FILE
  touch $MSG_TEMP_FILE
  # Add banner to the temporary file
  echo -e "$BANNER" >> $MSG_TEMP_FILE
}
msg-stop () {
  if [ $MSG_TEMP_FILE ]; then rm $MSG_TEMP_FILE; fi
}
msg-rpkgs-new () {
  # Read in previously created MSG
  MSG=$(<$MSG_TEMP_FILE)
  # Display message (no newline)
  clear
  echo -e "${CYAN}$MSG ${NOCOL}$1"
}
msg-rpkgs-success () {
  # Read in previously created MSG
  MSG=$(<$MSG_TEMP_FILE)
  # Display message (no newline)
  clear
  echo -e "${CYAN}$MSG ${GREEN}$1 ($2)"
  # Write additions to file
  MSG="$MSG ${GREEN}$1 ($2)"
  echo -e "$MSG" > $MSG_TEMP_FILE
}
msg-rpkgs-failure () {
  # Read in previously created MSG
  MSG=$(<$MSG_TEMP_FILE)
  # Display message (no newline)
  clear
  echo -e "${CYAN}$MSG ${RED}$1"
  # Write additions to file
  MSG="$MSG ${RED}$1"
  echo -e "$MSG" > $MSG_TEMP_FILE
}

# =================================================
#   VSCODE: Install vscode extensions and themes
# =================================================
# Install extensions listed in single array as argument
# e.g.  ext_list = (ext_id1 ext_id2)
#       vscode-install-extensions "${ext_list[@]}"
vscode-install-extensions () {
  extension_list=("$@")
  for ext in "${extension_list[@]}";
    do
      # Note: --force updates extension if it is already installed
      code --install-extension $ext --force
    done 
}


# =================================================
#             RPKGS: Install R packages
# =================================================
# Ensure R PPA apt repositories are added if not done already
# From: https://github.com/stan-dev/rstan/wiki/Configuring-C-Toolchain-for-Linux#ubuntu-lts-1604-1804-2004
rpkgs-ensure-ppas () {
  RRUTTER_FOUND=$(apt-cache policy | grep "marutter/rrutter4.0")
  C2D4U_FOUND=$(apt-cache policy | grep "c2d4u.team/c2d4u4.0+")
  if [ ! $RRUTTER_FOUND ]; then
    echo "Adding RRUTTER 4.0 PPA repository to apt"
    sudo add-apt-repository ppa:marutter/rrutter4.0
  fi
  if [ ! $C2D4U_FOUND ]; then
    echo "Adding cran2deb4ubuntu PPA repository to apt"
    sudo add-apt-repository -y ppa:c2d4u.team/c2d4u4.0+
  fi
}
rpkgs-is-installed () {
  R_CALL="if ('$1' %in% installed.packages()[,'Package']) cat(0) else cat(1)"
  return $(R -q --no-echo -e "$R_CALL")
}
rpkgs-get-version () {
  CRAN_PKG_NAME="$1"
  R_CALL="if ('$CRAN_PKG_NAME' %in% installed.packages()[, 'Package']){cat(installed.packages()['$CRAN_PKG_NAME', 'Version'])} else {cat('')}"
  R -q --no-echo -e "$R_CALL"
}
# Try install r package from crab2debian4ubuntu apt repo
rpkgs-try-install-apt () {
  CRAN_PKG_NAME=$1
  APT_PKG_NAME="r-cran-$1"
  sudo apt-get update -y
  IS_ON_APT=$(apt-cache search $APT_PKG_NAME)
  if [ IS_ON_APT ]; 
    then
      echo "Installing R package $CRAN_PKG_NAME with apt ($APT_PKG_NAME)"
      sudo apt-get install -y $APT_PKG_NAME
      return $?
    else 
      return 1
  fi  
}
# Try installing r package with r from CRAN repo
rpkgs-try-install-cran () {
  CRAN_PKG_NAME=$1
  R_CALL="install.packages($CRAN_PKG_NAME)"
  echo "Installing R package $CRAN_PKG_NAME with R from CRAN"
  R -e $R_CALL
  return $?
}
# MAIN INSTALL FUNCTION:
rpkgs-install () {
  PKG_NAME="$1"
  OLD_VERSION=""

  # Check if package is installed; if so, get version
  if rpkgs-is-installed $PKG_NAME 
    then 
      OLD_VERSION=$(rpkgs-get-version $PKG_NAME)
      echo "$PKG_NAME version $OLD_VERSION already installed, attempting to update..."
    else
      echo "Attempting to install $PKG_NAME"
  fi

  # Try install with APT and if not successful try with R CRAN
  if rpkgs-try-install-apt $PKG_NAME; then 
    INSTALLED_WITH="apt (r-cran-$PKG_NAME)"
  elif rpkgs-try-install-cran $PKG_NAME; then 
    INSTALLED_WITH="R from CRAN repository"    
  else 
    if [ "$OLD_VERSION" ]; then
      echo "\nFailed to update $PKG_NAME"
    else 
      echo "\nFailed to install $PKG_NAME"
      sleep 2
      return 1
    fi
  fi
  # Print success message
  if [ $OLD_VERSION ]; then 
    NEW_VERSION=$(rpkgs-get-version $PKG_NAME) 
    if [ $OLD_VERSION = $NEW_VERSION ] 
    then echo "The newest version of $PKG_NAME ($OLD_VERSION) is already installed."
    else echo "\nSuccess! $PKG_NAME version $OLD_VERSION updated to version $NEW_VERSION with $INSTALLED_WITH."
    fi
  else 
    echo "\nSuccess! $PKG_NAME version $(rpkgs-get-version $PKG_NAME) installed with $INSTALLED_WITH."
  fi
  sleep 2
  return 0
}
# Ensure R PPA apt repositories are added if not done already
# From: https://github.com/stan-dev/rstan/wiki/Configuring-C-Toolchain-for-Linux#ubuntu-lts-1604-1804-2004
rpkgs-ensure-ppas () {
  APT_POLICY=$(apt-cache policy)
  RRUTTER_FOUND=$($APT_POLICY | grep 'marutter/rrutter4.0')
  C2D4U_FOUND=$($APT_POLICY | grep 'c2d4u.team/c2d4u4.0+')
  if [ ! "RRUTTER_FOUND" ]; then
    echo "Adding RRUTTER 4.0 PPA repository to apt"
    sudo add-apt-repository ppa:marutter/rrutter4.0
  fi
  if [ ! "C2D4U_FOUND" ]; then
    echo "Adding cran2deb4ubuntu PPA repository to apt"
    sudo add-apt-repository -y ppa:c2d4u.team/c2d4u4.0+
  fi
}
rpkgs-is-installed () {
  CRAN_PKG_NAME="$1"
  R_CALL="if ('$CRAN_PKG_NAME' %in% installed.packages()[,'Package']) cat(0) else cat(1)"
  RES=$(R -q --no-echo -e $R_CALL)
  return $RES
}
rpkgs-get-version () {
  CRAN_PKG_NAME="$1"
  R_CALL="if ('$CRAN_PKG_NAME' %in% installed.packages()[, 'Package']){cat(installed.packages()['$CRAN_PKG_NAME', 'Version'])} else {cat('')}"
  R -q --no-echo -e $R_CALL
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

# =====================================
#         MAIN INSTALL FUNCTION
# =====================================
rpkgs-install () {
  # Expects ONE argument: the R package name ala install.packages("package name")
  if [ "$1" ]; 
    then
      PKG_NAME="$1"
    else 
      echo "Error in install_r_pkg: Missing R package name. [NOTE: install_r_pkg expects ONE argument, the name of the R package to install (e.g. install_r_pkg tidyverse)]"
      return 1
  fi

  # Check if package is installed; if so, get version
  rpkgs-is-installed $PKG_NAME; ALREADY_INSTALLED=$?
  if [ ALREADY_INSTALLED = 0 ]; 
    then 
      VERSION=$(rpkgs-get-version $PKG_NAME)
      echo "$PKG_NAME version $VERSION already installed, attempting to update...\n"
    else
      echo "Attempting to install $PKG_NAME"
  fi

  # Try install with APT and if not successful try with R CRAN
  rpkgs-try-install-apt $PKG_NAME; SUCCESS_APT=$?
  if [ $SUCCESS_APT = 1 ]; then
      rpkgs-try-install-cran $PKG_NAME; SUCCESS_CRAN=$?
  fi

  # Print failure message
  if [ $SUCCESS_APT = 0 ]; then
    INSTALLED_WITH="apt (r-cran-$PKG_NAME)"
  elif [ $SUCCESS_CRAN ]; then
    INSTALLED_WITH="R from CRAN repository"
  else 
    if [ ALREADY_INSTALLED = 0 ]
    then echo "\nFailed to update $PKG_NAME"
    else echo "\nFailed to install $PKG_NAME"
    fi
    return 1
  fi

  # Print success message
  if [ ALREADY_INSTALLED = 0 ]
  then 
    NEW_VERSION=$(rpkgs-get-version $PKG_NAME) 
    if [ $VERSION = $NEW_VERSION ] 
    then echo "The newest version of $PKG_NAME ($VERSION) is already installed."
    else echo "\nSuccess! $PKG_NAME version $VERSION updated to version $NEW_VERSION with $INSTALLED_WITH."
    fi
  else echo "\nSuccess! $PKG_NAME version $(rpkgs-get-version $PKG_NAME) installed with $INSTALLED_WITH."
  fi

  return 0
}
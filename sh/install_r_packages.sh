#!/bin/bash

# =====================================
#           BDEV R PACKAGES
# =====================================
r_packages=(

  # =====================
  #       Statistics
  # =====================
  # =====> General
  'performance'	# Assess model quality
  'survival'	  # Survival analysis in R
  # =====> Bayesian
  'bayesnec'	  # Beccy's bayesian no effect concentration modelling
  'bayesplot'
  'brms'
  'cmdstanr'
  'INLA'
  'inlabru'	    # Spatial modelling with INLA	#spatial
  'loo'	        # Leave-One-Out cross validation
  'rjags'	      # Interface to JAGS
  'rstan'		    # Interface to STAN
  'rstantools'	# Tools for building R packages which interface with STAN	packages
  'tidybayes'	  # Visualizations for Bayesian model validation	modelling	validation
  # =====> Frequentist 
  'DHARMa'
  'glmmTMB'	    # Powerful frequentist modelling (GLMMs)
  'lme4'        # Linear models
  # ======================
  #          Data 
  # ======================
  'janitor'	    # Data cleaning (incl. clean_names())
  'lubridate'	  # Date manipulation
  'readxl'	    # Read excel file formats	data
  'tidyverse'	  # A CORE COLLECTION OF R PACKAGES	#core	
  # =====================
  #       Plotting
  # =====================
  'corrplot'		#data exploration
  'dagitty'	    # Directed Acyclic Graphs (DAGs) #modelling
  'GGally'	    # Extends ggplot	data viz	plots
  'gganimate'
  'ggdag'	      # Directed Acyclic Graphs (DAGs) #modelling
  'ggh4x'	      # Extends ggplot (better facetting)
  'ggpubr'	    # Arrange plots
  'ggsci'	      # Color palettes based on science journals and sci-fi
  'latex2exp'	  # Use latex to write plot labels
  'leaflet'	    # Interactive maps	#widgets
  'patchwork'	  # Arrange plots
  'plotly'	    # Interactive ggplots	#widgets
  # ======================
  #        Tables
  # ======================
  'kableExtra'	  # Extends knitr::kable
  'modelsummary'	# Model summary tables
  'reactablefmtr' # Interactive tables	#widgets
  # =======================
  #     Marine Science
  # =======================
  'fishflux'	  # Model elemental fluxes in fishes	fish	
  'fishualize'	# Color palettes based on teleost fishes	data viz	color palettes
  'rfishbase'	  # Interface to fishbase	fish	
  'rfishprod'	  # Model fish productivity	fish
  # =======================
  #        Spatial
  # =======================
  'geosphere'	  # Distance between coordinates (and more)
  'ncdf4'	      # Netcdf file handling
  'sf'	        # Simple features - a standardised way to encode spatial data
  'terra'	      # Spatial data analysis
  # ======================
  #  Programming/General
  # ======================
  'conflicted'	# Handle function name conflicts
  'colorDF'	    # Print DFs in color to terminal
  'crayon'	    # Colored terminal output	terminal
  'crosstalk'	  # Inter-widget interactivity #widgets
  'curl'	      # libcurl C library for R
  'furrr'	      # Mapping functions in parallel
  'future'	    # Parallel and distributed processing
  'glue'	      # Interpretted string literals
  'here'	      # Project-based file referencing
  'htmltools'	
  'htmlwidgets' #widgets
  'httpgd'	    # Internal plot viewing in vscode
  'knitr'
  'languageserver' # for vscode	
  'learnr'	    # Interactive tutorials
  'pkgdown'	    # Build R packages #packages
  'quarto'
  'remotes'	    # Get packages from non-CRAN repos #packages
  'roxygen2'	  # Create documentation when building R packages	#packages
  'rlang'	      # Collection of frameworks and APIs for R programming
  'tarchetypes'	# Extends targets (e.g. render quarto documents from pipline)	targets	
  'targets'     # Efficient and smart modelling (and other) pipelines
  'testthat'	  # Unit testing	#packages
  'tinytex'	    # Latex for R	other
  'utf8'	      # Unicode text processing	other	
  # =========END============
)

# =====================================
#           HELPER FUNCTIONS
# =====================================
# Ensure R PPA apt repositories are added if not done already
# From: https://github.com/stan-dev/rstan/wiki/Configuring-C-Toolchain-for-Linux#ubuntu-lts-1604-1804-2004
ensure_r_ppas () {
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
is_installed () {
  CRAN_PKG_NAME="$1"
  R_CALL="if ('$CRAN_PKG_NAME' %in% installed.packages()[,'Package']) cat(0) else cat(1)"
  RES=$(R -q --no-echo -e $R_CALL)
  return $RES
}
get_installed_version () {
  CRAN_PKG_NAME="$1"
  R_CALL="if ('$CRAN_PKG_NAME' %in% installed.packages()[, 'Package']){cat(installed.packages()['$CRAN_PKG_NAME', 'Version'])} else {cat('')}"
  R -q --no-echo -e $R_CALL
}
# Try install r package from crab2debian4ubuntu apt repo
try_install_r_pkg_with_apt () {
  CRAN_PKG_NAME=$1
  APT_PKG_NAME="r-cran-$1"
  ensure_c2d4u
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
try_install_r_pkg_with_cran () {
  CRAN_PKG_NAME=$1
  R_CALL="install.packages($CRAN_PKG_NAME)"
  echo "Installing R package $CRAN_PKG_NAME with R from CRAN"
  R -e $R_CALL
  return $?
}
msg_rpkgs_new () {
  PKG=$1
  clear
  MSG="$MSG\n    - $PKG"
  echo "$MSG\n"
}
msg_rpkgs_success () {
  VER=$1
  MSG="$MSG ($VER) ✔️"
  clear
  echo $MSG

}
msg_rpkgs_failure () {
  MSG="$MSG ❌"
  clear
  echo $MSG
}

# =====================================
#         MAIN INSTALL FUNCTION
# =====================================
install_r_pkg () {
  # Expects ONE argument: the R package name ala install.packages("package name")
  if [ "$1" ]; 
    then
      PKG_NAME="$1"
    else 
      echo "Error in install_r_pkg: Missing R package name. [NOTE: install_r_pkg expects ONE argument, the name of the R package to install (e.g. install_r_pkg tidyverse)]"
      return 1
  fi

  # Check if package is installed; if so, get version
  is_installed $PKG_NAME; ALREADY_INSTALLED=$?
  if [ ALREADY_INSTALLED = 0 ]; 
    then 
      VERSION=$(get_installed_version $PKG_NAME)
      echo "$PKG_NAME version $VERSION already installed, attempting to update...\n"
    else
      echo "Attempting to install $PKG_NAME"
  fi

  # Try install with APT and if not successful try with R CRAN
  try_install_r_pkg_with_apt $PKG_NAME; SUCCESS_APT=$?
  if [ $SUCCESS_APT = 1 ]; then
      try_install_r_pkg_with_cran $PKG_NAME; SUCCESS_CRAN=$?
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
    NEW_VERSION=$(get_installed_version $PKG_NAME) 
    if [ $VERSION = $NEW_VERSION ] 
    then echo "The newest version of $PKG_NAME ($VERSION) is already installed."
    else echo "\nSuccess! $PKG_NAME version $VERSION updated to version $NEW_VERSION with $INSTALLED_WITH."
    fi
  else echo "\nSuccess! $PKG_NAME version $(get_installed_version $PKG_NAME) installed with $INSTALLED_WITH."
  fi

  return 0
}

# =====================================
#          INSTALL R PACKAGES
# =====================================
sudo :
MSG="Installing R packages"
for P in $r_packages
do
  msg_rpkgs_new $P
  install_r_pkg $P
  is_installed $P; P_INSTALLED=$?
  if $(is_installed $P)
    then msg_rpkgs_success "$(get_installed_version $P)"
    else msg_rpkgs_failure
  fi
done
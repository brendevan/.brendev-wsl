# ======================================================
#                   INSTALL R PACKAGES
# ======================================================

bdev.packages <<- c(
# =====================
#       Statistics
# =====================
# ====== General ====== 
'performance',	# Assess model quality
'survival',	    # Survival analysis in R
# ====== Bayesian =====
'bayesnec',	    # Beccy's bayesian no effect concentration modelling
'bayesplot',
'brms',
'cmdstanr',
'INLA',
'inlabru',	    # Spatial modelling with INLA	#spatial
'loo',	        # Leave-One-Out cross validation
'rjags',	      # Interface to JAGS
'rstan',		    # Interface to STAN
'rstantools',	  # Tools for building R packages which interface with STAN	packages
'tidybayes',	  # Visualizations for Bayesian model validation	modelling	validation
# ===== Frequentist ====
'DHARMa',
'glmmTMB',	    # Powerful frequentist modelling (GLMMs)
'lme4',         # Linear models
# ======================
#         Data 
# ======================
'janitor',	    # Data cleaning (incl. clean_names())
'lubridate',	  # Date manipulation
'readxl',	      # Read excel file formats	data
'tidyverse',	  # A CORE COLLECTION OF R PACKAGES	#core	
# =====================
#       Plotting
# =====================
'corrplot',		  #data exploration
'dagitty',	    # Directed Acyclic Graphs (DAGs) #modelling
'GGally',	      # Extends ggplot	data viz	plots
'gganimate',
'ggdag',	      # Directed Acyclic Graphs (DAGs) #modelling
'ggh4x',	      # Extends ggplot (better facetting)
'ggpubr',	      # Arrange plots
'ggsci',	      # Color palettes based on science journals and sci-fi
'latex2exp',	  # Use latex to write plot labels
'leaflet',	    # Interactive maps	#widgets
'patchwork',	  # Arrange plots
'plotly',	      # Interactive ggplots	#widgets
# ======================
#        Tables
# ======================
'kableExtra',	  # Extends knitr::kable
'modelsummary',	# Model summary tables
'reactablefmtr',# Interactive tables	#widgets
# =======================
#     Marine Science
# =======================
'fishflux',	    # Model elemental fluxes in fishes	fish	
'fishualize',	  # Color palettes based on teleost fishes	data viz	color palettes
'rfishbase',	  # Interface to fishbase	fish	
'rfishprod',	  # Model fish productivity	fish
# =======================
#        Spatial
# =======================
'geosphere',	  # Distance between coordinates (and more)
'ncdf4',	      # Netcdf file handling
'sf',	          # Simple features - a standardised way to encode spatial data
'terra',	        # Spatial data analysis
# ======================
#  Programming/General
# ======================
'conflicted',	  # Handle function name conflicts
'colorDF',	    # Print DFs in color to terminal
'crayon',	      # Colored terminal output	terminal
'crosstalk',	  # Inter-widget interactivity #widgets
'curl',	        # libcurl C library for R
'furrr',	      # Mapping functions in parallel
'future',	      # Parallel and distributed processing
'glue',	        # Interpretted string literals
'here',	        # Project-based file referencing
'htmltools',	
'htmlwidgets',  #widgets
'httpgd',	      # Internal plot viewing in vscode
'knitr',
'languageserver', # for vscode	
'learnr',	      # Interactive tutorials
'pkgdown',	    # Build R packages #packages
'quarto',
'remotes',	    # Get packages from non-CRAN repos #packages
'roxygen2',	    # Create documentation when building R packages	#packages
'rlang',	      # Collection of frameworks and APIs for R programming
'tarchetypes',	# Extends targets (e.g. render quarto documents from pipline)	targets	
'targets',      # Efficient and smart modelling (and other) pipelines
'testthat',	    # Unit testing	#packages
'tinytex',	    # Latex for R	other
'utf8'	        # Unicode text processing	other	
# =========END============
)

# INSTALL MISSING PACKAGES
# From: https://stackoverflow.com/questions/4090169/elegant-way-to-check-for-missing-packages-and-install-them
# Note: If you put your code in a package and the packages you want to install dependencies, then they will automatically be installed when you install your package.
bdev.get.installed.packages <- function (which="bdev", pkg_list=bdev.packages) {
  if (which == "bdev") {
    res <- pkg_list[(pkg_list %in% installed.packages()[,"Package"])]
  } else if (which == "all") {
    res <- installed.packages()[,"Package"]
  }
  return(sort(res))
}
bdev.get.missing.packages <- function (pkg_list=bdev.packages) {
  pkg_list[!(pkg_list %in% installed.packages()[,"Package"])]
}
bdev.install.packages <- function (install="missing", pkg_list=bdev.packages) {
  if (install %in% c("missing", "next")) {
    missing_pkgs <- bdev.get.missing.packages(pkg_list)
    if (length(missing_pkgs)) {
      if (install == "missing") {
        install.packages(missing_pkgs)
      }
      if (install == "next") {
        next_missing_pkg <- missing_pkgs[1]
        message(paste("Installing", next_missing_pkg)); Sys.sleep(2)
        install.packages(next_missing_pkg)
        warnings()
      }
    }
  } else if (install == "everything") {
    install.packages(pkg_list)
  } else {
    stop("Argument `install` must be one of 'missing', 'next', 'everything' (i.e. install all missing pkgs, next missing pkg, or reinstall all bdev pkgs)")
  }  
}

bdev.install.everything <- function (pkg_list=bdev.packages) {
  install.packages(pkg_list)
}

# Flag used to install packages from bash script
if ("--install-missing" %in% commandArgs()) {
  bdev.install.packages(bdev.packages)
}

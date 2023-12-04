# ================================
#               GIT
# ================================
# GIT-AUDIT: list all files in history 
alias git-audit='git log --pretty=format: --name-only --diff-filter=A  | sort -u'

# ================================
#               BDEV
# ================================

# ====> BDEV-DOTFILES-*
# BDEV-DOTFILE-RELINK: rerun the dotfiles script (creates symlinks to dotfiles in BDEV/dotfiles)
alias bdev-dotfiles-reconfig='bash $BDEV/sh/link_dotfiles.sh'

# ====> BDEV-VSCODE-*
alias bdev-vscode-reconfig='bash $BDEV/sh/vscode.sh'

# ====> BDEV-R-*
# Print bdev R packages not yet installed
alias bdev-r-get-missing-pkgs='R -q --no-echo -e "source(file.path(\"$BDEV\", \"r\", \"install_packages.r\")); bdev.get.missing.packages()"'
# Print installed bdev R packages
alias bdev-r-get-installed-pkgs='R -q --no-echo -e "source(file.path(\"$BDEV\", \"r\", \"install_packages.r\")); bdev.get.installed.packages()"'
# Print all installed R packages (incl. pkgs not listed here)
alias bdev-r-get-installed-pkgs-all='R -q --no-echo -e "source(file.path(\"$BDEV\", \"r\", \"install_packages.r\")); bdev.get.installed.packages(which=\"all\")"'
# Try to install all missing bdev R packages
alias bdev-r-install-all-missing-pkgs='sudo R -q --no-echo -e "source(file.path(\"$BDEV\", \"r\", \"install_packages.r\")); bdev.install.packages(install=\"missing\")"'
# Try to install next missing bdev R package
alias bdev-r-install-next-missing-pkg='sudo R -q --no-echo -e "source(file.path(\"$BDEV\", \"r\", \"install_packages.r\")); bdev.install.packages(install=\"next\")"'

# ================================
#          VSCODE/CODIUM
# ================================
alias code-extensions-dir='code --extensions-dir'
alias code-list-extensions='code --list-extensions'














# !!NOT WORKING!! 
# WSL: Add nameserver to resolv.conf
# When WSL can't connect to the internet, we need to find out the DNS Server in form X.X.X.X by calling
# >>> ipconfig /all
# in a windows terminal. Copy the DNS Server from the "* WiFi" entry. Then pass 
# "X.X.X.X" 
# to this function. It will then make resolv.conf writeable (chattr), append the new server ("nameserver X.X.X.X"), and make resolv.conf unwritable again.
# Method from here: https://gist.github.com/coltenkrauter/608cfe02319ce60facd76373249b8ca6
# bdev-addNameserver () {
#   if [ -n "$1" ]
#   then
#     sudo chattr -i /etc/resolv.conf
#     echo "nameserver "$1 | sudo tee -a resolv.conf
#     sudo chattr +i /etc/resolv.conf
#     echo "cat /etc/resolv.conf"
#     cat /etc/resolv.conf
#   else
#     echo "Error: missing DNS server string. Please pass the WiFi DNS Server as 'X.X.X.X' e.g. > bdev-addNameserver '192.32.254.143'"
#   fi
# }




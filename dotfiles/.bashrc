# =============================
#     ENVIRONMENT VARIABLES
# =============================
export BDEV=$HOME/.brendev-wsl
export ALIAS_BASH=$BDEV/aliases/.bash_aliases
export ALIAS_BDEV=$BDEV/aliases/.bdev_aliases
export NOTES="$HOME/.notes"
# =============================
#           ALIASES
# =============================
load_aliases () {
  if [ -f $1 ]
    then . $1
    else echo "Warning: Alias file not found at $1"
  fi
}
load_aliases $ALIAS_BASH
load_aliases $ALIAS_BDEV


# =============================
#      LOAD BDEV PROGRAMS
# =============================
source $BDEV/programs/notes.sh

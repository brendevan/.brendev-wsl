# =============================
#     ENVIRONMENT VARIABLES
# =============================
export BDEV=/home/brendan/.brendev-wsl
export ALIAS_BASH=$BDEV/aliases/.bash_aliases
export ALIAS_BDEV=$BDEV/aliases/.bdev_aliases

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




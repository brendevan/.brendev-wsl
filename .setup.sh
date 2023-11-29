bdev-setup () {
  if [ ! "$1" ]
    then BDEV=$HOME/.brendev-wsl
    else BDEV=$1/.brendev-wsl
  fi
  source $BDEV/sh/helper.sh
  bdev-log "bash $BDEV/sh/main.sh"
}
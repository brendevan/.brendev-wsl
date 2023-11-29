# ============================================
#    MSG: Print progress messages for run.sh 
# ============================================
msg () {
  # Read in previously created MSG
  MSG=$(<$MSG_TEMP_FILE)
  # Display message
  CYAN='\033[0;36m'
  BLUE='\033[0;34m'
  NOCOL='\033[0m'
  clear
  echo -e "${CYAN}$MSG\n${BLUE}$1${NOCOL}\n"
  # Write additions to file
  MSG="$MSG\n$1"
  echo -e "$MSG" > $MSG_TEMP_FILE
}
msg-start () {
  MSG_TEMP_FILE=$BDEV/.msg-temp
  # Garbage collection
  test -f $MSG_TEMP_FILE && msg-stop
  # Export path to MSG temporary storage file
  export MSG_TEMP_FILE=$MSG_TEMP_FILE
  touch $MSG_TEMP_FILE
  # Add banner to the temporary file
  BANNER="=======================================================\n 🐟 SETTING UP BREN(dan's)DEV(elopment environment) 🐟 \n======================================================="
  echo -e "$BANNER" >> $MSG_TEMP_FILE
}
msg-stop () {
  rm $MSG_TEMP_FILE
  unset MSG_TEMP_FILE
}

# ============================================
#    BDEV: helper functions for bdev setup 
# ============================================
bdev-export () {
  msg "\n🦈 Setting BDEV environment variable to $1"
  EXPORT_BDEV="export BDEV=$1"
  eval $EXPORT_BDEV
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

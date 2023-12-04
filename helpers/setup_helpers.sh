# =================================================
#    MSG: Print progress messages for BDEV setup
# =================================================
BANNER="\
=======================================================\n\
 🐟 SETTING UP BREN(dan's)DEV(elopment environment) 🐟 \n\
======================================================="
CYAN='\033[0;36m'
BLUE='\033[0;34m'
NOCOL='\033[0m'
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
  MSG_TEMP_FILE=$BDEV/.msg-temp
  # Garbage collection
  test -f $MSG_TEMP_FILE && msg-stop
  # Export path to MSG temporary storage file
  export MSG_TEMP_FILE=$MSG_TEMP_FILE
  touch $MSG_TEMP_FILE
  # Add banner to the temporary file
  echo -e "$BANNER" >> $MSG_TEMP_FILE
}
msg-stop () {
  rm $MSG_TEMP_FILE
  unset MSG_TEMP_FILE
}
msg-rpkgs-new () {
  # Read in previously created MSG
  MSG=$(<$MSG_TEMP_FILE)
  # Display message (no newline)
  clear
  echo -e "${CYAN}$MSG ${NOCOL}$1"
}

msg-rpkgs-success () {
  PKG=$1
  VERSION=$2
  # Read in previously created MSG
  MSG=$(<$MSG_TEMP_FILE)
  # Display message (no newline)
  clear
  echo -e "${CYAN}$MSG ${GREEN}$PKG ($VERSION)"
  # Write additions to file
  MSG="$MSG ${GREEN}$PKG ($VERSION)"
  echo -e "$MSG" > $MSG_TEMP_FILE
}
msg-rpkgs-failure () {
  PKG=$1
  # Read in previously created MSG
  MSG=$(<$MSG_TEMP_FILE)
  # Display message (no newline)
  clear
  echo -e "${CYAN}$MSG ${RED}$PKG ($VERSION)"
  # Write additions to file
  MSG="$MSG ${RED}$PKG ($VERSION)"
  echo -e "$MSG" > $MSG_TEMP_FILE
}
# =================================================
#      MISC: General functions used in setup
# =================================================
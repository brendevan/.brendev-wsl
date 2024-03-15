# ================================
#            SYSTEM
# ================================
alias back='cd -'

# ================================
#              GIT
# ================================
# GIT-AUDIT: list all files in history 
alias git-audit='git log --pretty=format: --name-only --diff-filter=A  | sort -u'

# ================================
#          VSCODE/CODIUM
# ================================
alias code-extensions-dir='code --extensions-dir'
alias code-list-extensions='code --list-extensions'

# ================================
#            R/radian
# ================================
alias r='radian'

# ================================
#             TRASH
# ================================
alias rm='trash'
TRASH=$HOME/.local/share/Trash
trash-path () {
  echo $TRASH
}
trash-files () {
  if [ -z "$(ls -A $TRASH/files)" ]
    then echo "No files in trash"
    else ls $TRASH/files
  fi
}
trash-info () {
  if [ -z "$(ls -A $TRASH/info)" ]
    then echo "Trash info folder is empty"
    else 
      if [ "$1" ]
        then
          if [ -f $TRASH/$1".trashinfo" ]
            then cat $TRASH/$1".trashinfo"
            else echo "No trash info file found for "$1
          fi
        else 
          ls $TRASH/info | sed 's/\.trashinfo$//'
          echo "Get info for trashed file with \`trash-info %file.name%\`"
      fi
  fi
}
trash-status () {
  nfiles=$(ls -1 $TRASH/files | wc -l)
  ninfo=$(ls -1 $TRASH/info | wc -l)
  if [ $nfiles = 0 ] && [ $ninfo = 0 ]
    then echo "Trash is empty"
    else 
      echo "  $nfiles file(s)"
      echo "  $ninfofiles information file(s)"
  fi
}
trash-search () {
  if [ "$1" ]
    then 
      if [ -f $TRASH/files/$1 ]
        then echo "File found at $TRASH/files/$1"
        else echo "! File not found in trash"
      fi
    else echo "Filename required \`trash-search %file.name%\`"
  fi
}
trash-delete () {
  if [ "$1" ]
    then 
      if [ -f $TRASH/files/$1 ] || [ -f "$TRASH/info/$1.trashinfo" ]
        then 
          if [ -f $TRASH/files/$1 ]; then 
            command rm $TRASH/files/$1
            echo "File deleted from trash"
          fi
          if [ -f "$TRASH/info/$1.trashinfo" ]; then 
            command rm "$TRASH/info/$1.trashinfo" 
            echo "File info deleted from trash"
          fi
        else echo "! File not found in trash"
      fi
    else echo "! Filename required \`trash-delete %file.name%\`"
  fi
}
trash-empty () {
  if [ -z "$(ls -A $TRASH/files)" ] && [ -z "$(ls -A $TRASH/info)" ]
    then echo "Trash is already empty"
    else 
      if read -q "?Permanently delete all trashed items (Y/y)? "
        then
          echo
          nfiles=$(ls -1 $TRASH/files | wc -l)
          ninfo=$(ls -1 $TRASH/info | wc -l)
          # Delete files and information from trash
          setopt rm_star_silent      # Allow rm --force in zsh for .../* file paths
          if [ $nfiles > 0 ]; then command rm -rf $TRASH/files/*; fi
          if [ $ninfo > 0 ]; then command rm -rf $TRASH/info/*; fi
          unsetopt rm_star_silent
          # Print message to terminal
          echo "Deleted $nfiles file(s) and $ninfo information file(s) from trash"
        else 
          echo
          echo "Abort, abort"
      fi
  fi
}
trash-help () {
  echo "brendev custum trash functions:"
  echo " - trash-path: path to trash folder"
  echo " - trash-files: list files in trash"
  echo " - trash-info: list information files in trash"
  echo " - trash-status: list how many files/information files are in trash"
  echo " - trash-search %file.name%: search for specific file in trash"
  echo " - trash-delete %file.name%: delete specific file from trash"
  echo " - trash-empty: take out the trash (warning: permanent)" 
  echo "[\`trash --help\` for trash-cli]"
}

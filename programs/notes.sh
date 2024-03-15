# ================================
#             NOTES
# ================================
# REQUIRES: $NOTES environment variable which defines path to notes folder which is a git repository.

# HELPER: Ensure notes folder exists and is a git repo
_notes-check () {
  if [ ! -d $NOTES ]; 
  then
    echo "Error! Notes directory $NOTES not found. Clone a git repository called .notes in the home folder to use notes."
    return 1
  else
    if ! git -C $NOTES rev-parse 2>/dev/null ; then
      echo "Error! Notes directory $NOTES is not a git repository. It needs to be in order to use notes."
      return 2
    fi
  fi
  return 0
}

# USER FUNCTIONS: 
# Backup notes to github
notes-backup () {
  if _notes-check; then
    if [[ `git -C $NOTES status --porcelain` ]]; # Check if there are changes to push
    then 
      echo "Pushing all notes and edits to github"
      git -C $NOTES add --all
      git -C $NOTES commit -m "Save notes"
      git -C $NOTES push
    else
      echo "No new notes or edits to save"
    fi
  fi
}
# Open a note, creating a new one if it doesnt exist
notes-open () {
  if _notes-check; then
    if [ "$1" ] # Ensure note name (first argument)
    then
      # Search for previously existing notes file
      # First, remove file extension
      if [[ $1 == *.*.* ]]; then 
        echo "Error! Invalid note name (only a single '.' may be used to denote the file extention)"
        return
      fi
      note_name="${1%%.*}" # Remove file extension if present
      if [[ $1 == *"/"* ]]
      then files_found=$(find $NOTES -wholename "*$1.*")
      else files_found=$(find $NOTES -name "$1.*")
      fi
      file_count=$(echo "$files_found" | wc -l)
      
      # If no matches, open new note
      if [ $file_count = 0 ]; then 
        # Check name has at least one topic and topics/name begin with a character  
        if  [[ $1 =~ ^[[:alpha:]][[:alnum:]_.-]*/([[:alpha:]][[:alnum:]_.-]*/)*[[:alpha:]][[:alnum:]_.-]*$ ]]
        then 
          echo "New note at $NOTES/$1 created and opened"
          code $NOTES/$1
        else 
          echo "Error! Invalid note name"
          echo "Every note must be stored within at least one topic and all topics and note names must begin with a character"
          echo "note <topic>/<optional subtopic>/.../<optional subtopic>/<note name>"
        fi
      fi
      # If a single match, open it
      if [ $file_count = 1 ]; then
        code $files_found
        echo "Existing note at $files_found opened"
      fi
      if (( $file_count > 1 )); then
        echo "Error! Multiple notes match your supplied name"
        echo $files_found
      fi
    else 
      echo "Error! No note name given. What should I open?"
    fi
  fi
}
notes-tree () {
  if _notes-check; then
    output=$(tree $NOTES -C)
    modified_output=$(echo "$output" | \
      sed -e "s#/home/brendan#~#" \
          -e "s/ directories/ topics/" \
          -e "s/ files/ notes/" \
          -e 's/_/ /g' \
          -e 's/\.[^.]*$//')
    # Extract counts of directories (topics) and files (notes)
    ntopics=$(echo "$output" | tail -n 1 | awk '{print $1}')
    nnotes=$(echo "$output" | tail -n 1 | awk '{print $3}')
    # Rearrange the last line
    if [ $nnotes = 1 ]; 
      then notes_string="${nnotes} note"
      else notes_string="${nnotes} notes"
    fi
    if [ $ntopics = 1 ];
      then topics_string="${ntopics} topic"
      else topics_string="${ntopics} topics"
    fi
    # Print the modified output without the last line
    echo "$modified_output" | head -n -1
    echo "$notes_string in $topics_string"
  fi
}
# Either print all notes or, if a search term was provided, search notes
notes-search () {
  if _notes-check; then
    # If a search term was provided, search in notes
    if [ "$1" ]
    then 
      output=$(tree $NOTES -P "*$1*" --ignore-case --prune -C)
      modified_output=$(echo "$output" | \
      sed -e "s#/home/brendan#~#" \
          -e "s/ directories/ topics/" \
          -e "s/ files/ notes/")
      # Extract counts of directories (topics) and files (notes)
      ntopics=$(echo "$output" | tail -n 1 | awk '{print $1}')
      nnotes=$(echo "$output" | tail -n 1 | awk '{print $3}')
      # Rearrange the last line
      if [ $nnotes = 1 ]; 
        then notes_string="${nnotes} note"
        else notes_string="${nnotes} notes"
      fi
      if [ $ntopics = 1 ];
        then topics_string="${ntopics} topic"
        else topics_string="${ntopics} topics"
      fi
      # Print the modified output without the last line
      echo "$modified_output" | head -n -1
      echo "$notes_string found in $topics_string"
    else 
      echo "Error! No search term provided"
    fi
  fi
}
# Delete notes
notes-rm () {
  if _notes-check; then 
    NOTE="$NOTES/$1"
    if [ -f $NOTE ]
    then trash $NOTE
    else 
      echo "Error! Note not found at $NOTE"
      echo "To enable autocompletion, you can also send notes to the trash can with"
      echo "trash \$NOTES/<topic>/.../<note_name>"
      echo "Or you can delete them for good with"
      echo "rm \$NOTES/<topic>/.../<note_name>"
    fi
  fi
}
notes-help () {
  echo "===================== NOTES ====================="
  echo "Notes are stored in: $NOTES"
  echo ""

  echo "Function:               Description                            Alias:         "
  echo " notes-backup           push all notes and edits to github                    "      
  echo " notes-open <note>      open a new or existing note in vscode  note <note>    "
  echo " notes-rm <note>        send note to trash (see trash --help)                 " 
  echo " notes-search <pattern> show tree of matching notes            notes <pattern>"
  echo " notes-tree             show tree of all notes                 notes          "
  echo ""
  echo "In the below descriptions <note> is a placeholder for note paths of the form"
  echo "<topic>/{Optional: <subtopic>/.../<subtopic>}/<note_name>"
}

# ALIASES
note () {
  notes-open $1
}
notes () {
  if [ "$1" ]; 
  then 
    if [[ $1 == *"/"* ]]; then 
      echo "Warning! Searching in specific topics is not supported :("
      1="${1##*/}"
      echo "Searching for '$1' in all notes"; echo ""
    fi
    notes-search "$1"
  else notes-tree
  fi
}
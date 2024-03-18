# ================================
#             NOTES
# ================================
# REQUIRES: $NOTES environment variable which defines path to notes folder which is a git repository.


# ALIASES
notes () {

  # -----------------------------------------------------------------------
  #                         BACKGROUND FUNCTIONS
  # -----------------------------------------------------------------------
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
  _notes-list-topics () {
    find $NOTES -type d -printf "%P\n" | grep -vE '^\.|^$'
  }
  _notes-find () {
  # First, remove file extension
    if [ ! "$1" ]; then 
      return 1
    fi
    if [[ $1 == *.*.* ]]; then 
      return 2
    fi
    note_name="${1%%.*}" # Remove file extension if present
    if [[ $1 == *"/"* ]]
    then files_found=$(find $NOTES -wholename "*$note_name.*")
    else files_found=$(find $NOTES -name "$note_name.*")
    fi
    echo $files_found | sed -e '/^[[:space:]]*$/d' # Remove blanklines
    return 0
  }
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
  # Open an existing note
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
          echo "Error! No notes found."
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
  # Open a new note
  notes-new () {
    if _notes-check; then
      # Check name has at least one topic and topics/name begin with a character  
      if [ "$1" ]
      then
        if  [[ $1 =~ ^[[:alpha:]][[:alnum:]_.-]*/([[:alpha:]][[:alnum:]_.-]*/)*[[:alpha:]][[:alnum:]_.-]*$ ]]
        then 
          echo "New note at $NOTES/$1 created and opened"
          code $NOTES/$1
        else 
          echo "Error! Invalid note name"
          echo "Every note must be stored within at least one topic and all topics and note names must begin with a character"
          echo "note <topic>/<optional subtopic>/.../<optional subtopic>/<note name>"
        fi
      else echo "Error! No note name supplied. See notes-help" 
      fi
    fi
  }
  # List notes in a tree structure
  notes-tree () {
    if _notes-check; then
      header="~"
      if [ "$1" ]
      then 
        # If the topic is found change root to topic
        if _notes-list-topics | grep -q "^$1$"
        then
          header=$1
          root=$NOTES/$1
        else 
          echo ("Error! topic $1 not found (list all topics with notes-list; see notes --help)")
          return
        fi
      else root=$NOTES
      fi
      output=$(tree $root -C)
      modified_output=$(echo "$output" | \
        sed -e "s#/home/brendan#~#" \
            -e "s/ directories/ topics/" \
            -e "s/ files/ notes/" \
            -e 's/_/ /g'  \
            -e 's/\([^/]\)\.[^.]*\([[:space:]]\|$\)/\1\2/g')
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
        if [[ $1 == *"/"* ]]; then 
          echo "Warning! Searching in specific topics is not supported :("
          1="${1##*/}"
          echo "Searching for '$1' in all notes"; echo ""
        fi
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
      if _notes-find $1 >/dev/null; then 
        files_found=$(_notes-find $1) | sed -e '/^[[:space:]]*$/d'
        file_count=$(echo "$files_found" | wc -l)
        echo $files_found
        echo $file_count
        return
      else echo "didn't find"; return
      fi
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
  # Print help page
  notes-help () {
    if _notes-check; then
      echo "===================== NOTES ====================="
      echo "Notes are stored in: $NOTES"
      echo ""
      echo "FUNCTIONS:                   DESCRIPTION                           ALIASES:"
      echo " notes push                  push all notes and edits to github    save backup"      
      echo " notes open <{...}/t/n | n>  open an existing note in vscode"
      echo " notes new <t/{...}/n>       open a new note"
      echo " notes rm <t/{...}/n>        send note to trash (see trash --help) delete remove" 
      echo " notes search <pattern in n> print a tree of matching notes"
      echo " notes list                  print a tree of all notes             tree"
      echo ""
      echo "t for topic, {} for optional, ... for additional topics, and n for note"
      echo ""
      echo "EXAMPLE: Say we have a note called targets in the topics 'r' (r/targets.md) 'notes open targets' will search all notes for one called targets and open it if a single file is found. If however we have another targets note withinn the topic 'archery' - subtopic 'buylist (archery/buylist/targets.txt), we can the search from lower level topics back, e.g. 'notes open 'buylist/targets' or 'notes open 'r/targets'. When creating a new note or removing a note, the requirements for the argument are a bit different (symbolised by <t/{...}/n>). Here we need to call 'notes <new/rm> full/topic/path/to/note'. When searching for notes, we can only search the note name (not the topics), e.g. 'notes search tar' but not 'notes search r/tar'."
      echo ""
      echo "USE CONVENTIONS:"
      echo " 1) topics and note names should"
      echo "      - start with a character"
      echo "      - contain no spaces, instead only underscores and if you must, dashes"
      echo " 2) every note must be in a topic"
      echo " 3) supply file extensions when creating/removing targets, but you don't need to when openning"
    fi
  }

  # -----------------------------------------------------------------------
  #                          USER INTERFACE
  # -----------------------------------------------------------------------
  if [ "$1" ]; 
  then
    if   [[ "$1" == "new" ]];  then 
      notes-new $2
    elif [[ "$1" == "open" ]]; then 
      notes-open $2
    elif [[ "$1" == "push" || "$1" == "backup" || "$1" == "save" ]]; then
      notes-backup
    elif [[ "$1" == "rm" || "$1" == "remove" || "$1" == "delete" ]]; then
      notes-rm $2
    elif [[ "$1" == "list" || "$1" == "tree" ]]; then
      if [[ "$2" ]]
      then notes-tree $2
      else notes-tree
      fi
    elif [[ "$1" == "search" ]]; then
      notes-search $2
    elif [[ "$1" == "help" || "$1" == "--help" ]]; then
      notes-help
    else 
      echo "Error! Invalid argument (see notes --help)"
    fi
  else notes-help
  fi
}

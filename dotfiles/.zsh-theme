SYM_ICON='🐟'         # 🦑 🐙 🐠 🐟 🐡 🦈 🐬 🐳 🐋
SYM_ICON_ERROR='🚩'   # 
SYM_PROMPT=' 🠊 '      # ❯ ▶ 🠊 🠖 ⯮ ⮚ 🠶

COL_DIR='cyan'
COL_GIT='blue'
COL_GIT_DIRTY='yellow'

PROMPT="%(?:%{$fg_bold[green]%}%1{$SYM_ICON%} :%{$fg_bold[red]%}%1{$SYM_ICON_ERROR%} )%{$fg[$COL_DIR]%}%c%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[$COL_GIT]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[$COL_GIT]%})%{$fg[yellow]%}%1{$SYM_PROMPT%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[$COL_GIT]%})%{$fg[blue]%}%1{$SYM_PROMPT%}"

# PROMPT PLACEHOLDERS (check values with print -P <placeholder>; e.g. print -P %d)
# %n - username
# %m - short name of curent host
# %M - name of curent host
# %# - a `%` or a `#`, depending on whether the shell is running as root or not
# %~ - relative path
# %/ or %d - absolute path
# %c or %C - Trailing  component of the current working directory.
# %t - time 12hr am/pm format
# %T - time 24hr format
# %w - day and date (day-dd)
# %D - Date (default: yy-mm-dd)
# %D{%f} - day of the month
# %l or %y - The  line  (tty)  the  user is logged in on, without `/dev/' prefix.
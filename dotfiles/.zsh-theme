# ALTERNATE SYMBOLS
# STYLE:    🦑 🐙 🐠 🐟 🐡 🦈 🐬 🐳 🐋
# ERROR:    🚩
# PROMPT:   ❯ ▶ 🠊 🠖 ⯮ ⮚ 🠶

SYM_ICON='🐟'
SYM_ICON_ERROR='🚩'

PROMPT='%(?:$SYM_ICON :$SYM_ICON_ERROR )%F{blue}%B%c%b%f'
PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX='%F{cyan}('
ZSH_THEME_GIT_PROMPT_SUFFIX=''
ZSH_THEME_GIT_PROMPT_DIRTY=')%f%F{yellow} 🠊  %f'
ZSH_THEME_GIT_PROMPT_CLEAN=')%f%F{cyan} 🠊  %f'

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
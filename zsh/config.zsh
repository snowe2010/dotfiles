export LSCOLORS="exfxcxdxbxegedabagacad"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=4 # color the autosuggestions better

# ZSH_THEME="edvardm"
HIST_FIND_NO_DUPS="true"
DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"

export CLICOLOR=true

fpath=($DOTFILES/functions $fpath)
autoload -U $DOTFILES/functions/*(:t)
#[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

HIST_FIND_NO_DUPS="true"

# setopt NO_BG_NICE # don't nice background tasks
# setopt NO_HUP
setopt NO_HIST_BEEP
# setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt HIST_VERIFY # when doing a bang substitution this makes you verify before execution
setopt SHARE_HISTORY # share history between sessions, but not if using ! unless history is used
setopt EXTENDED_HISTORY # add timestamps to history
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF

setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_REDUCE_BLANKS
setopt hist_ignore_space
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
# setopt complete_aliases # this causes non completion on git aliases from the oh-my-zsh git aliases plugin :/

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

# copied from oh-my-zsh/key-bindings.zsh
# start typing + [Up-Arrow] - fuzzy find history forward
# if [[ "${terminfo[kcuu1]}" != "" ]]; then
#   autoload -U up-line-or-beginning-search
#   zle -N up-line-or-beginning-search
#   bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
# fi
# start typing + [Down-Arrow] - fuzzy find history backward
# if [[ "${terminfo[kcud1]}" != "" ]]; then
#   autoload -U down-line-or-beginning-search
#   zle -N down-line-or-beginning-search
#   bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
# fi
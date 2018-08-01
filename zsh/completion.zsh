# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# cache stuff for grunt at least
zstyle ':completion:*' use-cache yes

# zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

# Fix for zsh-autopair https://github.com/hlissner/zsh-autopair#zgen--prezto-compatibility
AUTOPAIR_INHIBIT_INIT=1

source "${HOME}/.zgen/zgen.zsh"
# if the init scipt doesn't exist
if ! zgen saved; then
  zgen oh-my-zsh  
  # zgen load mafredri/zsh-async  
  zgen load lib/completion  
  # zgen load lukechilds/zsh-nvm
  zgen oh-my-zsh plugins/spring  
  zgen oh-my-zsh plugins/sublime  
  zgen oh-my-zsh plugins/wd
  # zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/gitfast
  zgen oh-my-zsh plugins/colored-man-pages
  zgen load djui/alias-tips
  zgen load zsh-users/zsh-history-substring-search
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-autosuggestions             # auto suggest what you should run
  zgen load denysdovhan/spaceship-prompt spaceship    # awesome terminal prompt
  zgen load wfxr/forgit                               # fzf ♥️ git
  # zgen load Valiev/almostontop                        # clear prompt when new command is run
  zgen load MikeDacre/careful_rm                      # overrides rm to make it safer and add ability to trash
  # zgen load desyncr/auto-ls                           # auto ls when cd'ing 
  zgen load hlissner/zsh-autopair                     # auto-close and delete matching delimiters 
  zgen load Tarrasch/zsh-bd                           # jump back directories. has autocomplete as well
  # zgen load mfaerevaag/wd                           # can't get wd to work without oh-my-zsh currently. 
  zgen load RobSis/zsh-completion-generator
  zgen load b4b4r07/emoji-cli
  zgen load MichaelAquilina/zsh-emojis
  zgen load urbainvaes/fzf-marks

  zgen save
fi

# Fix for zsh-autopair https://github.com/hlissner/zsh-autopair#zgen--prezto-compatibility
autopair-init

SPACESHIP_PROMPT_ORDER=(
  time          # Time stampts section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  dotnet        # .NET section
  ember         # Ember.js section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

# Fix for zsh-autopair https://github.com/hlissner/zsh-autopair#zgen--prezto-compatibility
AUTOPAIR_INHIBIT_INIT=1

source "${HOME}/.zgen/zgen.zsh"
# if the init scipt doesn't exist
if ! zgen saved; then
  zgen load zuxfoucault/colored-man-pages_mod
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-history-substring-search
  zgen load zsh-users/zsh-autosuggestions             # auto suggest what you should run
  zgen load denysdovhan/spaceship-prompt spaceship    # awesome terminal prompt
  zgen load wfxr/forgit                               # fzf ♥️ git
  # zgen load Valiev/almostontop                      # clear prompt when new command is run
  zgen load MikeDacre/careful_rm                      # overrides rm to make it safer and add ability to trash
  zgen load hlissner/zsh-autopair                     # auto-close and delete matching delimiters 
  zgen load Tarrasch/zsh-bd                           # jump back directories. has autocomplete as well
  zgen load RobSis/zsh-completion-generator
  zgen load b4b4r07/emoji-cli
  zgen load MichaelAquilina/zsh-emojis
  zgen load urbainvaes/fzf-marks                      # fzf ♥️ bookmarks
  zgen load mroth/git-prompt-useremail                # notifies which email will be used for git commit
  zgen load caarlos0/zsh-git-sync                     # sync with upstream fork
  zgen load packruler/zsh-git-scripts                 # remove merged branches, squash branch
  zgen load jedahan/ripz                              # alias tips in rust. requires ripgrep
  zgen load peterhurford/up.zsh                       # cd up easier: up 1, up 3, etc.

  # Testing
  # zgen load AlexisBRENON/oh-my-zsh-reminder           # better reminders??? commands: `todo` `task_done`
  # zgen load changyuheng/zsh-interactive-cd
  # zgen load tevren/gitfast-zsh-plugin
  # zgen load rummik/zsh-ing                            # ping but shorter output
  zgen load Tarrasch/zsh-autoenv                      # automatically run stuff when entering a directory

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
  # hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  # elixir        # Elixir section
  # xcode         # Xcode section
  # swift         # Swift section
  # golang        # Go section
  # php           # PHP section
  rust          # Rust section
  # haskell       # Haskell Stack section
  # julia         # Julia section
  docker        # Docker section
  # aws           # Amazon Web Services section
  venv          # virtualenv section
  # conda         # conda virtualenv section
  pyenv         # Pyenv section
  # dotnet        # .NET section
  # ember         # Ember.js section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  # vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

export RPROMPT='$(git_prompt_useremail_symbol) ' # make right prompt display which user I'm committing as
export RIPZ_TEXT='💋'

# look into timewarrior

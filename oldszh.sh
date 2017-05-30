# Path to your oh-my-zsh installation.
export ZSH=/Users/tylerthrailkill/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="awesomepanda"
ZSH_THEME="edvardm"
LSCOLORS="exfxcxdxbxegedabagacad"
# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
HIST_FIND_NO_DUPS="true"
# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-nvm brew bundler colorize common-aliases fancy-ctrl-z git git-flow git-prompt gitfast grunt gulp jsontools lol mvn nyan spring sublime thefuck themes fasd)

# User configuration
export JAVA_HOME=$(/usr/libexec/java_home)

# Maven Configuration
export M2_HOME=~/Applications/ActiveVersions/Maven
#export MAVEN_OPTS='-Xmx1024m -Djava.security.egd=file:/dev/./urandom'

# Gradle Configuration
export GRADLE_HOME=~/Applications/ActiveVersions/Gradle

# Docker Configuration

# Kafka Configuration
# export KAFKA_HOME=~/Applications/ActiveVersions/Kafka

# WebDriver Configuration
export PHANTOM_JS=~/Applications/ActiveVersions/PhantomJS

# ** Terminal Preference and Configuration **



export PATH="$M2_HOME/bin:$GRADLE_HOME/bin:$PHANTOM_JS/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#Add the following line to your ~/.bash_profile or ~/.zshrc file (and remember
#to source the file to update your current session):
  [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

#If you use the Fish shell then add the following line to your ~/.config/fish/config.fish:
#  [ -f /usr/local/share/autojump/autojump.fish ]; and . /usr/local/share/autojump/autojump.fish

eval $(thefuck --alias)
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

alias findextension="find . -type f -name "
alias deleteextension="find . -type f -delete -name "
eval "$(rbenv init -)"
alias history=history
alias ms="mvn spring-boot:run"
alias mci="mvn clean install"
#alias gffs="git flow feature start"
alias gfff="git flow feature finish"
alias gffp="git flow feature publish"
function gffs {
  git flow feature start $1 $2
  git flow feature publish $1
}
function gfco {
  gco feature/LP-$1
}

source ~/git-completion.bash

PATH=$PATH:/usr/local/sbin:/Users/tylerthrailkill/scripts
alias change-commits="!f() { VAR=$1; OLD=$2; NEW=$3; shift 3; git filter-branch --env-filter \"if [[ \\\"$`echo $VAR`\\\" = '$OLD' ]]; then export $VAR='$NEW'; fi\" $@; }; f "


function set_iterm_title {
  echo -ne "\e]1;$1\a"
}

function git_branch {
  BRANCH_REFS=$(git symbolic-ref HEAD 2>/dev/null) || return
    GIT_BRANCH="${BRANCH_REFS#refs/heads/}"
      [ -n "$GIT_BRANCH" ] && echo "$GIT_BRANCH "
}

function precmd {
  set_iterm_title "${PWD//*\//} >$(git_branch)<"
    #PROMPT="%c %{$fg[cyan]%}$(git_branch)%{$reset_color%}%# "
}
ssh-add -A 2>/dev/null;
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:~/.cargo/bin
alias reload!='. ~/.zshrc'

export NVM_DIR="/Users/tylerthrailkill/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export JWT_SIGNING_KEY=anything


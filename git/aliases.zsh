# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
# hub_path=$(which hub)
# if (( $+commands[hub] ))
# then
  # alias git=$hub_path
# fi

# The rest of my fun git aliases
# alias gl='git pull --prune'
# alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
# alias gp='git push origin HEAD'

# Remove `+` and `-` from start of diff lines; just rely upon color.
# alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'

# alias gc='git commit'
# alias gca='git commit -a'
# alias gco='git checkout'
# alias gcb='git copy-branch-name'
# alias gb='git branch'
# alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
# alias gac='git add -A && git commit -m'


# Custom Git Aliases
alias gfff="git flow feature finish"
alias gffp="git flow feature publish"
function gffs {
  git flow feature start $1 $2
  git flow feature publish $1
}
function gfco {
  git checkout feature/LP-$1
}



alias change-commits="!f() { VAR=$1; OLD=$2; NEW=$3; shift 3; git filter-branch --env-filter \"if [[ \\\"$`echo $VAR`\\\" = '$OLD' ]]; then export $VAR='$NEW'; fi\" $@; }; f "

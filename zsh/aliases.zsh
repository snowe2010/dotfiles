alias reload!='. ~/.zshrc'

alias cls='clear' # Good 'ol Clear Screen command


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

alias change-commits="!f() { VAR=$1; OLD=$2; NEW=$3; shift 3; git filter-branch --env-filter \"if [[ \\\"$`echo $VAR`\\\" = '$OLD' ]]; then export $VAR='$NEW'; fi\" $@; }; f "

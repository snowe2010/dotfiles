# From http://dotfiles.org/~_why/.zshrc
# Sets the window title nicely no matter where you are
function title() {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")

  case $TERM in
  screen)
    print -Pn "\ek$a:$3\e\\" # screen title (in ^A")
    ;;
  xterm*|rxvt)
    print -Pn "\e]2;$2\a" # plain xterm title ($3 for pwd)
    ;;
  esac
}


function set_iterm_title {
  echo -ne "\e]1;$1\a"
}

function git_branch {
  BRANCH_REFS=$(git symbolic-ref HEAD 2>/dev/null) || return
    GIT_BRANCH="${BRANCH_REFS#refs/heads/}"
      [ -n "$GIT_BRANCH" ] && echo "$GIT_BRANCH"
}

function precmd {
  set_iterm_title "${PWD//*\//} <$(git_branch)>"
    #PROMPT="%c %{$fg[cyan]%}$(git_branch)%{$reset_color%}%# "
}
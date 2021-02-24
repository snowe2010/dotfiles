# todo
# add fisher
# fisher sdkman


set -x DOTFILES ~/.dotfiles

starship init fish | source

# bind \cg fzm

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end



###########
###########
# Aliases #
###########
###########

# General Aliases
alias reload!='. ~/.config/fish/config.fish'

# alias history=history
alias cls='clear' # Good 'ol Clear Screen command
alias findextension="find . -type f -name "
alias deleteextension="find . -type f -delete -name "

# Maven Aliases
alias ms="mvn spring-boot:run"
alias mci="mvn clean install"
alias mi="MAVEN_OPTS=\"-XX:+TieredCompilation -XX:TieredStopAtLevel=1\" mvn -T 2C install --offline -q"

# alias rake="noglob rake"

alias hammerspoon_id="/usr/libexec/PlistBuddy -c 'Print CFBundleIdentifier' $1"
# alias c=clear
alias k=kubectl
alias kga="k get all"
alias kgs="k get services"
alias kl="k logs -f $1"
alias kdp="k delete pod $1"
alias gco="git checkout --no-guess"

# function cgit
#   c_repos=(find . -maxdepth 2 -name .git -type d -print | cut -d'/' -f2)
#   c_basedir=${PWD}

#   for repo in ${c_repos}; do
#     echo "## [${repo}] "
#     git --git-dir="${c_basedir}/${repo}/.git" \
#       --work-tree="${c_basedir}/${repo}" \
#       "$@"
#     echo -e ""
#   done
# end

# From common-aliases oh-my-zsh plugin
# 
# Advanced Aliases.
# Use with caution
#

# ls, the common ones I use a lot shortened for rapid fire usage
alias ls='exa --long --header --git'
alias l='ls -lFh'     #size,show type,human readable
# alias la='ls -lAFh'   #long list,show almost all,show type,human readable
# alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
# alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -al'      #long list
alias ldot='ls -ld .*'
# alias lS='ls -1FSsh'
# alias lart='ls -1Fcart'
# alias lrt='ls -1Fcrt'

alias zshrc='$EDITOR ~/.zshrc' # Quick access to the ~/.zshrc file

alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

alias t='tail -f'

# Command line head / tail shortcuts
# alias -g H='| head'
# alias -g T='| tail'
# alias -g G='| grep'
# alias -g L="| less"
# alias -g M="| most"
# alias -g LL="2>&1 | less"
# alias -g CA="2>&1 | cat -A"
# alias -g NE="2> /dev/null"
# alias -g NUL="> /dev/null 2>&1"
# alias -g P="2>&1| pygmentize -l pytb"

alias dud='du -d 1 -h'
alias duf='du -sh *'

alias h='history'
alias hgrep="fc -El 0 | grep"
alias help='man'
alias p='ps -f'
alias sortnr='sort -n -r'
alias unexport='unset'

alias whereami=display_info

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias bookmark='mark (basename $PWD)'

alias cat='ccat --bg=dark'
# zsh is able to auto-do some kungfoo
# depends on the SUFFIX :)

## I DON"T KNOW WHAT THIS STUFF DOES
# autoload -U is-at-least
# if is-at-least 4.2.0; then
#   # open browser on urls
#   if [[ -n "$BROWSER" ]]; then
#     _browser_fts=(htm html de org net com at cx nl se dk)
#     for ft in $_browser_fts; do alias -s $ft=$BROWSER; done
#   fi

#   _editor_fts=(cpp cxx cc c hh h inl asc txt TXT tex)
#   for ft in $_editor_fts; do alias -s $ft=$EDITOR; done

#   if [[ -n "$XIVIEWER" ]]; then
#     _image_fts=(jpg jpeg png gif mng tiff tif xpm)
#     for ft in $_image_fts; do alias -s $ft=$XIVIEWER; done
#   fi

#   _media_fts=(ape avi flv m4a mkv mov mp3 mpeg mpg ogg ogm rm wav webm)
#   for ft in $_media_fts; do alias -s $ft=mplayer; done

#   #read documents
#   alias -s pdf=acroread
#   alias -s ps=gv
#   alias -s dvi=xdvi
#   alias -s chm=xchm
#   alias -s djvu=djview

#   #list whats inside packed file
#   alias -s zip="unzip -l"
#   alias -s rar="unrar l"
#   alias -s tar="tar tf"
#   alias -s tar.gz="echo "
#   alias -s ace="unace l"
# fi

alias gup="git pull -r -p --autostash"
# Make zsh know about hosts already accessed by SSH
# zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

function pssh
  ssh -i ~/.ssh/jumpcloud tyler.thrailkill@$1 $2 -t -- /bin/sh -c 'tmux has-session && exec tmux attach || exec tmux'
end

function pr
  hub pull-request -ocp -b $1 -a snowe2010 -r $2 -l $3
end

function authorities
  git checkout -b feature/$1
  java -jar ~/Documents/dev/iprojects/promontech-backend/authoritygenerator/target/authority-generator-1.0-SNAPSHOT.jar
  git add iam-deploy/src/main/resources/default_security_groups.yml
  git commit -m "$1 update authorities"
  gpsup
  hub pull-request -cp -b develop -a snowe2010 -r dallasacook,zhouij,levans002 -m "[$1] Update authorities" -l authorities
end

#### git aliases ####
alias grhh="git reset --hard origin/develop"
alias gpsup='git push --set-upstream origin (git_current_branch)'

# alias ping="ing"
alias weather="curl wttr.in/Denver"
alias cat=bat
alias b="./gradlew build"
alias bp="./gradlew build publishToMavenLocal"

function spam
  whois $1 | grep "Registrar Abuse Contact Email"
end

alias wip="git add --all && git commit -m \"wip\" && gc"
alias prune="git branch --merged >/tmp/merged-branches && vim /tmp/merged-branches && xargs git branch -d </tmp/merged-branches"
alias portainer="docker run -d -p 8099:8099 -p 10000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer --no-auth"

alias s="smerge ."
# alias docker="podman"

alias githome='git config user.name "Tyler B. Thrailkill" && git config user.email "tyler.b.thrailkill@gmail.com"'
alias gitwork='git config user.name "Tyler B. Thrailkill" && git config user.email "tyler.thrailkill@promontech.com"'
function code-changes
    git log --format=format: --name-only | egrep -v '^$' | sort | uniq -c | sort -rg | head -20
end
alias pr-develop="hub pull-request -ocp -b develop -r promontech/backend-engineering -a snowe2010"
alias pr-master="hub pull-request -ocp -b master -r promontech/backend-engineering -a snowe2010"






# Outputs the name of the current branch
# Usage example: git pull origin $(git_current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function git_current_branch
  set ref (command git symbolic-ref --quiet HEAD 2> /dev/null)
  if test $status -ne 0
    if test $status -eq 128
      return
    end
    set ref (command git rev-parse --short HEAD 2> /dev/null) || return
  end
  echo "$ref"
end


#
# Aliases
# (sorted alphabetically)
#

alias g='git'

alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'
alias gap='git apply'

alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
# alias gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'
alias gbD='git branch -D'
alias gbl='git blame -b -w'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcans!='git commit -v -a -s --no-edit --amend'
alias gcam='git commit -a -m'
alias gcsm='git commit -s -m'
alias gcb='git checkout -b'
alias gcf='git config --list'
alias gcl='git clone --recurse-submodules'
alias gclean='git clean -fd'
alias gpristine='git reset --hard && git clean -dfx'
alias gcm='git checkout master'
alias gcd='git checkout develop'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcs='git commit -S'

alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gdct='git describe --tags `git rev-list --tags --max-count=1`'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdw='git diff --word-diff'


alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gfo='git fetch origin'


alias gg='git gui citool'
alias gga='git gui citool --amend'


alias ggpur='ggu'

alias ggpull='git pull origin (git_current_branch)'

alias ggpush='git push origin (git_current_branch)'

alias ggsup='git branch --set-upstream-to=origin/(git_current_branch)'
alias gpsup='git push --set-upstream origin (git_current_branch)'

alias ghh='git help'

alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'

alias gk='\gitk --all --branches'
alias gke='\gitk --all (git log -g --pretty=%h)'

alias gl='git pull'
alias glg='git log --stat'
alias glgp='git log --stat -p'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --stat"
alias glod="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glp="_git_log_prettily"

alias gm='git merge'
alias gmom='git merge origin/master'
alias gmt='git mergetool --no-prompt'
alias gmtvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/master'
alias gma='git merge --abort'

alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease'
alias gpf!='git push --force'
alias gpoat='git push origin --all && git push origin --tags'
alias gpu='git push upstream'
alias gpv='git push -v'

alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbd='git rebase develop'
alias grbi='git rebase -i'
alias grbm='git rebase master'
alias grbs='git rebase --skip'
alias grh='git reset'
alias grhh='git reset --hard'
alias grm='git rm'
alias grmc='git rm --cached'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grset='git remote set-url'
alias grt='cd (git rev-parse --show-toplevel || echo ".")'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote -v'

alias gsb='git status -sb'
alias gsd='git svn dcommit'
alias gsh='git show'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status -s'
alias gst='git status'
alias gsta='git stash save'
alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
alias gstall='git stash --all'
alias gsu='git submodule update'

alias gts='git tag -s'
alias gtv='git tag | sort -V'

alias gunignore='git update-index --no-assume-unchanged'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias gup='git pull --rebase'
alias gupv='git pull --rebase -v'
alias gupa='git pull --rebase --autostash'
alias gupav='git pull --rebase --autostash -v'
alias glum='git pull upstream master'

alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm (git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'





##########
# Prompt #
##########

set SPACESHIP_PROMPT_ORDER time user dir host git package node ruby rust dockervenv pyenv exec_time line_sep battery jobs exit_code char 
set -U FZF_LEGACY_KEYBINDINGS 0

function start_release_branch
  echo $1
end

set PATH ~/.rbenv/shims $PATH

set -g fish_user_paths "/usr/local/opt/util-linux/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/util-linux/sbin" $fish_user_paths

export EDITOR='vim'


if test -z (pgrep ssh-agent)
  eval (ssh-agent -c)
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
  set -Ux SSH_AGENT_PID $SSH_AGENT_PID
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
end

status --is-interactive; and source (rbenv init -|psub)


#########################
#########################
#### WORK ##########
#########################
#########################

function awslogin
    aws-okta exec -t 12h "$argv" -- ~/.aws/sunrun_aws_okta.py;
end

set -x awslogin

source /usr/local/opt/asdf/asdf.fish
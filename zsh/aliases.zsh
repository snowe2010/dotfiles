# General Aliases
alias reload!='. ~/.zshrc'

alias history=history
alias cls='clear' # Good 'ol Clear Screen command
alias findextension="find . -type f -name "
alias deleteextension="find . -type f -delete -name "

# Maven Aliases
alias ms="mvn spring-boot:run"
alias mci="mvn clean install"

alias rake="noglob rake"

alias hammerspoon_id="/usr/libexec/PlistBuddy -c 'Print CFBundleIdentifier' $1"
alias c=clear
alias k=kubectl
alias kga="k get all"
alias kgs="k get services"
alias kl="k logs -f $1"
alias kdp="k delete pod $1"
alias gco="gco --no-guess"
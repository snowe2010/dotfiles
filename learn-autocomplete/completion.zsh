# _thorcomplete() {
#         compgen -W "`pt help | grep pt | awk '{print $2}'`" -- ${COMP_WORDS[COMP_CWORD]}
#         return 0
# }
# complete -o default -o nospace -F _thorcomplete thor
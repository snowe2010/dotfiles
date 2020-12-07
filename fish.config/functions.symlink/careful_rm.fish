#######################################################################
#                         careful_rm for fish                         #
#                       Has some extra goodies                        #
#######################################################################

# Get the alias
set -g OURDIR "(dirname $0:A)"
source "$OURDIR/careful_rm.alias.sh"

# Make a trash aliase that changes with directory
# function chpwd_trash
#     if test -x "$CAREFUL_RM"
#         set -g TRASH (python $CAREFUL_RM --get-trash)
#         if test [[ "$OSTYPE" == "linux-gnu" ]]
#             set -g TRASH "$TRASH/files"
#         end
#         hash -d trash="$TRASH"
#     end
# end
# set -g chpwd_functions ( chpwd_functions chpwd_trash )
# chpwd_trash
# alias trsh="cd \$TRASH"

alias rm="$CAREFUL_RM"
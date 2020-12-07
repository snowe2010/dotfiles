# The Brewfile handles Homebrew-based app and library installs, but there may
# still be updates and installables in the Mac App Store. There's a nifty
# command line interface to it that we can use to just install everything, so
# yeah, let's do that.


cd "$(dirname "$0")/.."
DOTFILES=$(pwd -P)
echo `pwd`
source $DOTFILES/bin/prompt.sh

confirm_yes "Update Mac Software?" && {
    echo "› sudo softwareupdate -i -a";
    sudo softwareupdate -i -a;
}

echo "" # if this isn't here, the rest of the install doesn't continue for some reason...

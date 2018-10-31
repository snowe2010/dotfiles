if [ ! -d "$HOME/.zgen" ]; then
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi
# before this will succeed you need to add /usr/local/bin/zsh to /etc/shells :(
chsh -s $(which zsh)

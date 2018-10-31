if [ ! -d "$HOME/.zgen" ]; then
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi
# before this will succeed you need to add /usr/local/bin/zsh to /etc/shells :(
if ! echo $SHELL | grep -q 'zsh'; then
    local shell_path;
    shell_path="$(which zsh)"

    if ! grep "$shell_path" /etc/shells > /dev/null 2>&1 ; then
        echo "Adding '$shell_path' to /etc/shells"
        sudo sh -c "echo $shell_path >> /etc/shells"
    fi
    chsh -s "$shell_path"
fi

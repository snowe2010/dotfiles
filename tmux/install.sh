if [ ! -d "$HOME/.tmuxifier" ]; then
    git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
fi

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

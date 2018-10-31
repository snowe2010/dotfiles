# install cargo
if ! command -v cargo &> /dev/null; then
    curl -sSf https://static.rust-lang.org/rustup.sh | sh 
fi
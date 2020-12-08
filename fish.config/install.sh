echo "Change shell to fish"

if [[ -z $(grep -q "$STRING" "$FILE") ]]; then 
  echo /usr/local/bin/fish |  sudo tee -a /etc/shells
  chsh -s /usr/local/bin/fish
fi

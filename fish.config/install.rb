puts "Change shell to fish"

fish = "/usr/local/bin/fish"
shells = File.open("/etc/shells")
unless shells.read.include?(fish)
    puts "Shell was not in /etc/shells, setting..."
    # File.write("/etc/shells", fish, mode: "a")
    `echo /usr/local/bin/fish |  sudo tee -a /etc/shells`
    `chsh -s /usr/local/bin/fish`
else
    puts "Fish was already the default shell"
end

# Sets reasonable macOS defaults.
#
# Or, in other words, set shit how I like in macOS.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
# Run ./set-defaults.sh and you'll be good to go.

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Show the ~/Library folder.
chflags nohidden ~/Library

# Set a really fast key repeat.
defaults write NSGlobalDomain KeyRepeat -int 1

# Set the Finder prefs for showing a few different volumes on the Desktop.
# defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
# defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Run the screensaver if we're in the bottom-left hot corner.
# defaults write com.apple.dock wvous-bl-corner -int 5
# defaults write com.apple.dock wvous-bl-modifier -int 0

# Hide Safari's bookmark bar.
# defaults write com.apple.Safari ShowFavoritesBar -bool false

# Set up Safari for development.
# defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
# defaults write com.apple.Safari IncludeDevelopMenu -bool true
# defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
# defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

# show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

###############
# Tunnelblick #
###############

# set vpn settings
defaults write net.tunnelblick.tunnelblick "promontech-openvpn-test-doNotDisconnectOnSleep" -int 1 
defaults write net.tunnelblick.tunnelblick "promontech-openvpn-test-doNotReconnectOnWakeFromSleep" -int 1
defaults write net.tunnelblick.tunnelblick "promontech-openvpn-test-doNotDisconnectOnFastUserSwitch" -int 1

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
# default: no default
defaults write com.apple.finder QuitMenuItem -bool true

## Finder: disable window animations and Get Info animations
# default: no default
defaults write com.apple.finder DisableAllAnimations -bool true

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
# For desktop use PfDe
# default: -string "PfLo" 
defaults write com.apple.finder NewWindowTarget -string "PfLo"
# default: 
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Documents/"

### Hide all icons on the desktop
# default: -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
# default: -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
# default: no default
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
# default: -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
# default: no default
defaults write com.apple.finder CreateDesktop -bool false

## Finder: show hidden files by default
# default: -bool false
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
# default: no default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
# default: -bool true (maybe)
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
# default: -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
# default: no default 
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
# default: no default
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
# default: no default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
# default: no default
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
# default: -bool true
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
# default: -float 0.4
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network or USB volumes
# default: no default
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# default: no default
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable disk image verification
# default: no default
defaults write com.apple.frameworks.diskimages skip-verify -bool true
# default: no default
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
# default: no default
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
# default: no default
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
# default: no default
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
# default: no default
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# # Show item info near icons on the desktop and in other icon views
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# # Show item info to the right of the icons on the desktop
# /usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

# # Enable snap-to-grid for icons on the desktop and in other icon views
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# # Increase grid spacing for icons on the desktop and in other icon views
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

# # Increase the size of icons on the desktop and in other icon views
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
# default: ?
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
# default: none
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
# default: true
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Remove Dropbox’s green checkmark icons in Finder
#file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
#[ -e "${file}" ] && mv -f "${file}" "${file}.bak"

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
# default: {
#     MetaData = 1;
#     Name = 1;
#     OpenWith = 1;
# }
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

# Dock: don't minimize to dock
# default: -bool false
defaults write com.apple.dock minimize-to-application -bool true